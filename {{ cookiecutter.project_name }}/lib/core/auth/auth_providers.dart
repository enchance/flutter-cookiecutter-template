import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> signInAnonymously() async {
    try {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final creds = await FirebaseAuth.instance.signInAnonymously();

        // Startup here
        Account? account = await StartupService.initialize(ref, creds);
        return account;
      });
    } on StateError catch (err) {
      logger.d(err);
    } catch (err, _) {
      rethrow;
    }
  }

  Future<void> linkGoogleAccount(User user) async {
    Account account = ref.watch(userAccountProvider)!;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
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
        );
        ref.read(userAccountProvider.notifier).save(account);

        await AccountService.save(account.uid, account.toJson());

        return account;
      } on FirebaseAuthException catch (err, _) {
        switch (err.code) {
          case 'provider-already-linked':
            logger.e('The provider has already been linked to the user.');
            break;
          case 'invalid-credential':
            logger.e("The provider's credential is not valid.");
            break;
          case 'credential-already-in-use':
            logger.e('Account already exists');
            // TODO: Sign them in using this account maybe?
            break;
          default:
            logger.e('Unknown error.');
        }
        signOut(fullSignOut: false);
        rethrow;
      }
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
      Account? account = await StartupService.initialize(ref, creds);
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
      Account? account = await StartupService.initialize(ref, creds);
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
      Account? account = await StartupService.initialize(ref, creds);
      return account;
    });
  }

  void signOut({bool fullSignOut = true}) {
    try {
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