import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../components/dialogs.dart';
import '../core.dart';

part 'providers.g.dart';

@riverpod
Stream<AuthAccount> authStream(AuthStreamRef ref) {
  final accountTransformer = StreamTransformer<User?, AuthAccount>.fromHandlers(
      handleData: (User? user, EventSink<AuthAccount> sink) async {
    try {
      if (user == null) throw UserNullException();
      final account = await AccountService.fetchOrCreate(user);
      if (account == null) throw AccountNullException();
      sink.add(AuthAccount(user, account));
    } on UserNullException {
      sink.add(const AuthAccount());
    } catch (err, _) {
      logger.e(err);
      sink.add(const AuthAccount());
    }
  });

  return FirebaseAuth.instance.authStateChanges().transform(accountTransformer);
}

final authAccountProvider = StateProvider<AuthAccount>((ref) => const AuthAccount());

final signOutTextProvider = StateProvider<String?>((ref) => null);

final authPendingProvider = StateProvider<String>((ref) => '');

// TODO: This used to be keepAlive=true in case it fails
@riverpod
class Auth extends _$Auth {
  Object? _key;

  @override
  FutureOr<UserCredential?> build() async {
    _key = Object();
    ref.onDispose(() => _key = null);
    return null;
  }

  Future<bool> fetchResources(Account account) async {
    final prefs = ref.watch(prefsProvider);

    try {
      // Config
      final configmod = await Startup.initConfig(prefs);
      ref.read(appConfigProvider.notifier).save(configmod);

      if (!prefs.containsKey('showOnboarding')) await prefs.setBool('showOnboarding', false);

      logger.d('FETCH_SUCCESS');
      return true;
    } catch (err, _) {
      return false;
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
      ref.read(authPendingProvider.notifier).update((_) => 'google');
      final creds = await AuthService.googleSignIn();
      if (creds == null) ref.read(authPendingProvider.notifier).update((_) => '');
      return creds;
    });
    if (key == _key) state = newState;
  }

  Future<void> linkAccount(BuildContext context) async {
    final key = _key;
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      Account account = ref.watch(accountProvider);

      try {
        ref.read(authPendingProvider.notifier).update((_) => 'linkGoogle');
        final creds = await AuthService.linkGoogleAccount();
        final user = creds?.user;
        if (user == null) return null;

        final email = user.email ?? '';
        final authType = AccountService.guessAuthType(user);
        String fullname = account.fullname;
        String display = account.display;

        if(fullname.isEmpty) {
          final (firstname, lastname) = splitName(email);
          fullname = '$firstname $lastname'.trim();
        }
        if(display.isEmpty) {
          display = user.displayName ?? parseDisplayName(fullname);
        }

        account = account.copyWith(
          email: email,
          display: display,
          fullname: fullname,
          avatar: creds?.additionalUserInfo?.profile?['picture'] ?? '',
          authTypes: [...account.authTypes, authType],
        );
        await AccountService.save(account.uid, account.toJson());
        ref.read(accountProvider.notifier).update((_) => account);
        return creds;
      } on FirebaseAuthException catch (err) {
        logger.e(err.code);
        if (err.code == 'credential-already-in-use') {
          if (context.mounted) {
            showErrorDialog(
              context,
              title: 'Account already exists',
              message: '''
If you're the owner of that account then we recommend just signing in again and choosing 
**Google Sign-in**.
''',
            );
          }
        }
        await GoogleSignIn().signOut();
        return null;
      } catch (err, _) {
        logger.e(err);
        await GoogleSignIn().signOut();
        return null;
      } finally {
        ref.read(authPendingProvider.notifier).update((_) => '');
      }
    });
    if (key == _key) state = newState;
  }

  /// DO NOT CALL THIS METHOD DIRECTLY. Use actions: signOut.
  /// Making [fullSignOut] false doesn't sign-out the user but instead only reenables the
  /// google account selection card for reselection.
  Future<void> signOut({bool fullSignOut = true}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await GoogleSignIn().signOut();
      if (fullSignOut) FirebaseAuth.instance.signOut(); // Complete sign-out
      return null;
    });
  }
}
