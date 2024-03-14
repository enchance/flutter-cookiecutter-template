import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core.dart';

part 'auth_providers.g.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) => AuthService(ref);

@riverpod
Stream<User?> authStream(AuthStreamRef ref) => FirebaseAuth.instance.authStateChanges();

@Riverpod(keepAlive: true)
class UserAccount extends _$UserAccount {
  @override
  Account? build() => null;

  void save(Account? item) => state = item;

  void clear() => state = null;
}

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<Account?> build() => null;

  Future<void> linkGoogleAccount(User user) async {
    Account account = ref.watch(userAccountProvider)!;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await Future.delayed(const Duration(seconds: 9999));
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final authCreds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCreds = await user.linkWithCredential(authCreds);
      user = userCreds.user!;

      String display = user.displayName ?? user.email!.split('@').first;
      account = account.copyWith(
        email: user.email!,
        display: display,
        firstName: display,
        avatar: userCreds.additionalUserInfo?.profile?['picture'] ?? '',
        protocols: [...account.protocols, AuthType.google],
      );
      logger.d(account);
      await AccountService.save(account.uid, account.toJson());
      ref.read(userAccountProvider.notifier).save(account);
      return account;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final authCreds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final creds = await FirebaseAuth.instance.signInWithCredential(authCreds);
      final user = creds.user;
      if (user == null) return null;

      // Startup
      Account? account = await StartupService.initAccount(ref, creds, AuthType.google);
      return account;
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = creds.user;
      if (user == null) return null;

      // Startup
      Account? account = await StartupService.initAccount(ref, creds);
      return account;
    });
  }

  Future<void> createUserWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final creds = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = creds.user;
      if (user == null) return null;

      // Startup
      Account? account = await StartupService.initAccount(ref, creds, AuthType.email);
      return account;
    });
  }

  void signOut({bool fullSignOut = true}) {
    try {
      // if (protocol == AuthProtocol.x) {
      // } else {
      // }
      GoogleSignIn().signOut();

      if (fullSignOut) {
        FirebaseAuth.instance.signOut();
        _exitCleanup();
      }
    } catch (err) {
      logger.e(err);
      rethrow;
    }
  }

  /// Reset items when the user signs out
  void _exitCleanup() {
    ref.read(startupCompleteProvider.notifier).update((state) => false);
    ref.read(userAccountProvider.notifier).clear();
    // ref.read(devLogProvider.notifier).clear();
  }
}


@riverpod
class AnonymousSignIn extends _$AnonymousSignIn {
  @override
  FutureOr<Account?> build() async => null;

  Future<void> signIn() async {
    try {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        // await Future.delayed(const Duration(seconds: 9999));
        final creds = await FirebaseAuth.instance.signInAnonymously();

        // Startup here
        Account? account = await StartupService.initAccount(ref, creds, AuthType.anonymous);
        return account;
      });
    } on StateError catch (err) {
      logger.d(err);
    } catch (err, _) {
      rethrow;
    }
  }
}

@riverpod
class xSignIn extends _$xSignIn {
  @override
  FutureOr<Account?> build() async => null;

  // Future<void> signInWithX() async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final xLogin = TwitterLogin(
  //       apiKey: dotenv.env['X_API_KEY']!,
  //       apiSecretKey: dotenv.env['X_SECRET']!,
  //       redirectURI: dotenv.env['X_REDIRECT_URL']!,
  //     );
  //     final AuthResult auth = await xLogin.login();
  //
  //     switch (auth.status) {
  //       case TwitterLoginStatus.loggedIn:
  //         final authCreds = TwitterAuthProvider.credential(
  //           accessToken: auth.authToken!,
  //           secret: auth.authTokenSecret!,
  //         );
  //         final creds = await FirebaseAuth.instance.signInWithCredential(authCreds);
  //         final user = creds.user;
  //         if (user == null) return null;
  //
  //         // Startup
  //         Account? account = await StartupService.initAccount(ref, creds, AuthType.x);
  //         return account;
  //         break;
  //       // case TwitterLoginStatus.cancelledByUser:
  //       //   break;
  //       default:
  //         return null;
  //     }
  //   });
  // }
}

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  FutureOr<bool?> build() => null;

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    });
  }
}
