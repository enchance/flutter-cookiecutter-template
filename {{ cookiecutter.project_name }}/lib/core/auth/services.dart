import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core.dart';

class AuthService {
  AuthService._();

  static Future<UserCredential> registerWithEmail(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential?> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final authCreds = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  static Future<UserCredential> emailSignin(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (err, _) {
      return false;
    }
  }

  static Future<UserCredential?> linkGoogleAccount() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final authCreds = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User user = FirebaseAuth.instance.currentUser!;
    return await user.linkWithCredential(authCreds);
  }

  static Future<UserCredential> anonymousSignIn() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  /// Upload [file] to Firebase Storage using data from [inventory].
  static Future<UploadTask> putFile(
      {required File file, required String path, Map<String, String>? metadata}) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final task = storageRef.putFile(
      file,
      metadata == null
          ? null
          : SettableMetadata(
              contentType: 'image/jpeg',
              customMetadata: metadata,
            ),
    );
    return task;
  }
}
