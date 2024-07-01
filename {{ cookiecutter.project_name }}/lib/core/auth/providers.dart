import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../components/dialogs.dart';
import '../core.dart';

part 'providers.g.dart';

// @riverpod
// Stream<AuthState> authStream(AuthStreamRef ref) {
//   // final accountTransformer = StreamTransformer<AuthState, Account?>.fromHandlers(
//   //     handleData: (AuthState state, EventSink<Account?> sink) async {
//   //   final supabase = Supabase.instance.client;
//   //   Account? account = ref.watch(accountProvider);
//   //   final session = state.session;
//   //   // logger.d(state.session);
//   //
//   //   if (session != null && account != null) return sink.add(account);
//   //
//   //   try {
//   //     // final user = session?.user;
//   //     final user = supabase.auth.currentUser;
//   //     if (user == null) throw UserNullException();
//   //     account = await AccountService.fetchOrCreate(user);
//   //     // if (account != null) ref.read(accountProvider.notifier).update((_) => account!);
//   //     if (account == null) throw AccountNullException();
//   //     // if(account == null) {
//   //     // }
//   //     sink.add(account);
//   //   } on UserNullException {
//   //     sink.add(null);
//   //   } on AccountNullException {
//   //     sink.add(null);
//   //   } catch (err, _) {
//   //     logger.e(err);
//   //     sink.add(null);
//   //   }
//   // });
//
//   final uselessTransformer = StreamTransformer<AuthState, AuthState>.fromHandlers(
//       handleData: (AuthState state, EventSink<AuthState> sink) async {
//     // print('TRANSFORMING');
//     sink.add(state);
//   });
//
//   return Supabase.instance.client.auth.onAuthStateChange.transform(uselessTransformer);
//   // return FirebaseAuth.instance.authStateChanges().transform(accountTransformer);
// }

@riverpod
Stream<User?> userStream(UserStreamRef ref) {
  final userTransformer = StreamTransformer<AuthState, User?>.fromHandlers(
      handleData: (AuthState state, EventSink<User?> sink) async {
    if (state.session == null) return sink.add(null);
    sink.add(state.session!.user);
  });
  return Supabase.instance.client.auth.onAuthStateChange.transform(userTransformer);
}

final signOutTextProvider = StateProvider<String?>((ref) => null);

final authPendingProvider = StateProvider<String>((ref) => '');

// TODO: This used to be keepAlive=true in case it fails
@riverpod
class Auth extends _$Auth {
  Object? _key;

  @override
  FutureOr<AuthResponse?> build() async {
    _key = Object();
    ref.onDispose(() => _key = null);
    return null;
  }

  /// If you need to run some commands before the user opens / you can group them here.
  Future<Account?> initializeTheThing(Account account) async {
    final prefs = ref.watch(prefsProvider);
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    // final authprov = ref.watch(authProvider);

    try {
      // Copy data from Google over account empty fields
      account = await _copyFromGoogleData(account);

      // Config
      final configmod = await Startup.initConfig(prefs);
      ref.read(appConfigProvider.notifier).save(configmod);

      if (!prefs.containsKey('showOnboarding')) await prefs.setBool('showOnboarding', false);
      return account;
    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  Future<Account> _copyFromGoogleData(Account account) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    try {
      // logger.d(user!.userMetadata);
      final avatar = user!.userMetadata!['avatar_url'] ?? '';
      final providerId = user.userMetadata!['provider_id'] ?? '';
      final providers = ((user.appMetadata['providers'] ?? []) as List)
          .cast<String>()
          .map((item) => AuthType.values.byName(item))
          .toSet();
      // print(providers);
      // print(avatar);

      // Update db with user data if necessary
      Map<String, dynamic> toUpdate = {};
      if (account.avatar.isEmpty && avatar.isNotEmpty) {
        toUpdate['avatar'] = avatar;
        account = account.copyWith(avatar: avatar);
      }
      if (account.providerId.isEmpty && providerId.isNotEmpty) {
        toUpdate['provider_id'] = providerId;
        account = account.copyWith(providerId: providerId);
      }
      if (providers.difference(account.providers).isNotEmpty) {
        toUpdate['providers'] = providers.map((item) => item.name).toList();
        account = account.copyWith(providers: providers);
      }
      if (toUpdate.isNotEmpty) {
        // TODO: Update auth_accounts with todUpdate
        await supabase.from('auth_accounts').update(toUpdate).eq('id', user.id);
      }
      return account;
    } catch (err, _) {
      logger.e(err);
      rethrow;
    }
  }

  Future<void> anonymousSignIn() async {
    state = const AsyncLoading();
    final key = _key;
    final newState = await AsyncValue.guard(() async {
      ref.read(authPendingProvider.notifier).update((_) => 'anonymous');
      return await AuthService.anonymousSignIn();
    });
    if (key == _key) state = newState;
  }

  Future<void> googleSignIn() async {
    final key = _key;
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;

      ref.read(authPendingProvider.notifier).update((_) => 'google');
      final authres = await AuthService.googleSignIn();
      if (authres == null) ref.read(authPendingProvider.notifier).update((_) => '');
      logger.d(supabase.auth.currentUser);

      return authres;
    });
    if (key == _key) state = newState;
  }

  // TODO: Incomplete linkGoogleIdentity()
  Future<void> linkGoogleIdentity() async {
    final supabase = Supabase.instance.client;
    final account = ref.watch(accountProvider);

    try {
      ref.read(authPendingProvider.notifier).update((_) => 'google');

      final success = await AuthService.googleLinkAccount();
      logger.d(success);
      // if (success) {
      //   logger.d('AAA');
      //   await _copyFromGoogleData(account);
      //   logger.d('BBB');
      // }

    } catch (err, _) {
      logger.e(err);
    }
    finally {
      ref.read(authPendingProvider.notifier).update((_) => '');
    }
  }

//   Future<void> linkGoogleAccount(BuildContext context) async {
//     final key = _key;
//     state = const AsyncLoading();
//     final newState = await AsyncValue.guard(() async {
//       Account account = ref.watch(accountProvider);
//       try {
// //         ref.read(authPendingProvider.notifier).update((_) => 'linkGoogle');
//         final aaa = await AuthService.linkGoogleAccount();
//         logger.d(aaa);
//         final supabase = Supabase.instance.client;
//         final user = supabase.auth.currentUser;
//         logger.d(user);
// //
// //         final email = user.email ?? '';
// //         final authType = AccountService.guessAuthType(user);
// //         String fullname = account.fullname;
// //         String display = account.display;
// //
// //         if (fullname.isEmpty) {
// //           final (firstname, lastname) = splitName(email);
// //           fullname = '$firstname $lastname'.trim();
// //         }
// //         if (display.isEmpty) {
// //           display = user.displayName ?? parseDisplayName(fullname);
// //         }
// //
// //         account = account.copyWith(
// //           email: email,
// //           display: display,
// //           fullname: fullname,
// //           avatar: creds?.additionalUserInfo?.profile?['picture'] ?? '',
// //           authTypes: [...account.authTypes, authType],
// //         );
// //         await AccountService.save(account.uid, account.toJson());
// //         ref.read(accountProvider.notifier).update((_) => account);
// //         return creds;
// //       } on FirebaseAuthException catch (err) {
// //         logger.e(err.code);
// //         if (err.code == 'credential-already-in-use') {
// //           if (context.mounted) {
// //             showErrorDialog(
// //               context,
// //               title: 'Account already exists',
// //               message: '''
// // If you're the owner of that account then we recommend just signing in again and choosing
// // **Google Sign-in**.
// // ''',
// //             );
// //           }
// //         }
// //         await GoogleSignIn().signOut();
// //         return null;
//       } catch (err, _) {
//         logger.e(err);
//         await GoogleSignIn().signOut();
//         return null;
//       } finally {
//         ref.read(authPendingProvider.notifier).update((_) => '');
//       }
//     });
//     if (key == _key) state = newState;
//   }

  /// DO NOT CALL THIS METHOD DIRECTLY. Use actions: signOut.
  /// Making [fullSignOut] false doesn't sign-out the user but instead only reenables the
  /// google account selection card for reselection.
  Future<void> signOut({bool fullSignOut = true}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;

      await GoogleSignIn().signOut();
      if (fullSignOut) await supabase.auth.signOut();
      // if (fullSignOut) FirebaseAuth.instance.signOut(); // Complete sign-out
      return null;
    });
  }
}
