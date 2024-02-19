import 'package:firebase_auth/firebase_auth.dart';
import 'package:popolscan/startup/startup.dart';

import '../core.dart';

class AuthService {
  Future<void> emailSignIn({required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  Future<void> signOut(dynamic ref) async {
    try {
      // final GoogleSignIn signin = GoogleSignIn();
      // signin.signOut();

      await FirebaseAuth.instance.signOut();
      ref.read(startupProvider.notifier).exitCleanup(ref);
    } catch (err) {
      logger.e(err);
      rethrow;
    }
  }

  Future<void> changePassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
