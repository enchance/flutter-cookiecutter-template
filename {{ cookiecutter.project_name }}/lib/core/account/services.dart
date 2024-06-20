import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../core.dart';

class AccountService {
  AccountService._();

  static Future<bool> save(String uid, Map<String, dynamic> datamap) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(C8n.accounts.name).doc(uid);
      await ref.update(datamap);
      return true;
    } catch (err, _) {
      return false;
    }
  }

  /// Get the account record for [uid] from Firestore if exists else create it.
  static Future<Account?> fetchOrCreate(User user) async {
    // logger.d(user);
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(C8n.accounts.name).doc(user.uid);
      final refget = await ref.get();

      Account account;
      final authType = guessAuthType(user);

      if (refget.exists) {
        logger.d('ACCOUNT_EXISTS');
        account = Account.fromJson(refget.data() as Map<String, dynamic>);
      } else {
        logger.d('CREATE_ACCOUNT');
        String email = user.email ?? '';
        String display = user.displayName ?? email.split('@').first;

        account = Account.create(
          uid: user.uid,
          display: display,
          email: user.email,
          avatar: user.photoURL,
          authType: authType,
        );
        await ref.set(account.toJson());
      }
      return account;
    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  static AuthType guessAuthType(User user) {
    if (user.isAnonymous) return AuthType.anonymous;
    if (user.providerData.first.providerId == 'google.com') return AuthType.google;
    if (user.providerData.first.providerId == 'password') return AuthType.email;
    return AuthType.unknown;
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

  static Future<bool> addAuthType(String uid, AuthType authType) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(C8n.accounts.name).doc(uid);
      await ref.update({
        'authTypes': FieldValue.arrayUnion([authType.name])
      });
      return true;
    } catch (err, _) {
      logger.e(err);
      return false;
    }
  }

  static Future<void> changeEmail(User? user, String newEmail) async {
    if (user == null) throw UserNullException();

    try {
      await user.verifyBeforeUpdateEmail(newEmail);
    } catch (err, _) {
      logger.e(err);
      rethrow;
    }
  }
}
