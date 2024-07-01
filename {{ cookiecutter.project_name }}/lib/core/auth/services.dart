import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core.dart';

class AuthService {
  AuthService._();

  static Future<AuthResponse> registerWithEmail(String email, String password) async {
    final supabase = Supabase.instance.client;
    return await supabase.auth.signUp(email: email, password: password);
  }

  static Future<AuthResponse?> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    final accessToken = googleAuth.accessToken;

    if (idToken == null) return null;
    if (accessToken == null) return null;

    final supabase = Supabase.instance.client;
    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  static Future<bool> googleLinkAccount() async {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      // final googleAuth = await googleUser.authentication;
      // final idToken = googleAuth.idToken;
      // final accessToken = googleAuth.accessToken;
      //
      // if (idToken == null) return false;
      // if (accessToken == null) return false;

      final supabase = Supabase.instance.client;
      // await supabase.auth.signInWithIdToken(
      //   provider: OAuthProvider.google,
      //   idToken: idToken,
      //   accessToken: accessToken,
      // );
      await supabase.auth.linkIdentity(OAuthProvider.google);


      // Update user data
      final userres = await supabase.auth.updateUser(UserAttributes(
        email: googleUser.email,
      ));
      logger.d(userres.user);
      // await _copyFromGoogleData(account);
      await GoogleSignIn().signOut(); // DEV
      return true;
    } catch (err, _) {
      logger.e(err);
      await GoogleSignIn().signOut();
      return false;
    }
  }

  // static Future<bool?> linkGoogleAccount() async {
  //   final googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) return null;
  //
  //   final googleAuth = await googleUser.authentication;
  //   final idToken = googleAuth.idToken;
  //   final accessToken = googleAuth.accessToken;
  //
  //   if (idToken == null) return null;
  //   if (accessToken == null) return null;
  //
  //   final supabase = Supabase.instance.client;
  //   return supabase.auth.linkIdentity(OAuthProvider.google);
  // }

  static Future<AuthResponse> emailSignin(String email, String password) async {
    final supabase = Supabase.instance.client;

    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    // return await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );
  }

  // static Future<bool> resetPassword(String email) async {
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     return true;
  //   } catch (err, _) {
  //     return false;
  //   }
  // }

  // static Future<UserCredential?> linkGoogleAccount() async {
  //   final googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) return null;
  //
  //   final googleAuth = await googleUser.authentication;
  //   final authCreds = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   User user = FirebaseAuth.instance.currentUser!;
  //   return await user.linkWithCredential(authCreds);
  // }

  static Future<AuthResponse> anonymousSignIn() async {
    final supabase = Supabase.instance.client;
    return await supabase.auth.signInAnonymously();
  }

  // /// Upload [file] to Firebase Storage using data from [inventory].
  // static Future<UploadTask> putFile(
  //     {required File file, required String path, Map<String, String>? metadata}) async {
  //   final storageRef = FirebaseStorage.instance.ref().child(path);
  //   final task = storageRef.putFile(
  //     file,
  //     metadata == null
  //         ? null
  //         : SettableMetadata(
  //             contentType: 'image/jpeg',
  //             customMetadata: metadata,
  //           ),
  //   );
  //   return task;
  // }
}
