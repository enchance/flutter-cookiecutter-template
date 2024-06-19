import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

import '../../components/dialogs.dart';
import '../core.dart';

part 'providers.g.dart';

@riverpod
Stream<User?> authStream(AuthStreamRef ref) => FirebaseAuth.instance.authStateChanges();

final signOutTextProvider = StateProvider<String?>((ref) => null);

final authPendingProvider = StateProvider<String>((ref) => '');

final accountProvider = StateProvider<Account>((ref) => Account.empty());

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
      Account account = ref.watch(accountProvider)!;

      try {
        ref.read(authPendingProvider.notifier).update((_) => 'linkGoogle');
        final creds = await AuthService.linkGoogleAccount();
        final user = creds?.user;
        if (user == null) return null;

        String display = user.displayName ?? user.email!.split('@').first;
        final authType = AccountService.guessAuthType(user);
        account = account.copyWith(
          email: user.email!,
          display: display,
          firstname: display,
          avatar: creds?.additionalUserInfo?.profile?['picture'] ?? '',
          authTypes: [...account.authTypes, authType],
          // authTypes: [...account.authTypes, AuthType.google],
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

  /// Do not call this method directly. Use actions: signOut.
  /// Setting [fullSignOut] to false doesn't sign-out the user but instead only reenables the
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