import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core.dart';

class AuthService {
  final AuthServiceRef _ref;

  AuthService(AuthServiceRef ref) : _ref = ref;

  AuthServiceRef get ref => _ref;

  Future<void> emailSignIn({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<void> changePassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

class AccountService {
  static Future<Account?> fetchAccount(String uid) async {
    final user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;

    if (user == null) return null;

    final ref = db.collection(Collection.accounts.name).doc(uid);
    final refget = await ref.get();
    if (!refget.exists) return null;

    Account account = Account.fromJson(refget.data() as Map<String, dynamic>);
    return account;
  }

  static Future<Account?> getFromStorage(
      FlutterSecureStorage secstor, Map<String, dynamic> accountMap, String accountKey,
      {bool isConnected = false}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    Account? account;
    try {
      if (isConnected || accountMap.isEmpty) throw MapToObjectException();

      // logger.d('USE_STORAGE');
      try {
        accountMap['createdAt'] = (accountMap['createdAt'] as String).decodeToTimestamp();
        account = Account.fromJson(accountMap);
        return account;
      } catch (err, _) {
        throw MapToObjectException();
      }
    } on MapToObjectException catch (_) {
      logger.d('[FETCHING_ACCOUNT] ${user.email}');
      account = await AccountService.fetchAccount(user.uid);
      if (account == null) return null;

      // TimestampConverter executes from freezed so use account.createdAt which is DateTime
      accountMap = account.toJson();
      accountMap['createdAt'] = account.createdAt!.toIso8601String();
      await secstor.write(key: accountKey, value: json.encode(accountMap));
    }
    return account;
  }

  /// Get the account record for [uid] from Firestore if exists else create it.
  static Future<Account?> getAndCreate({
    required User user,
    AuthType? protocol,
    String photoUrl = '',
  }) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(Collection.accounts.name).doc(user.uid);
      final refget = await ref.get();

      Account account;
      if (refget.exists) {
        // logger.d('EXISTS');
        try {
          account = Account.fromJson(refget.data() as Map<String, dynamic>);
          logger.d(account);
        } catch (err, _) {
          logger.e(err);
          rethrow;
        }
        if (protocol != null && !account.protocols.contains(protocol)) {
          await AccountService.addProtocol(account.uid, protocol);
          account = account.copyWith(protocols: [...account.protocols, protocol]);
        }
      } else {
        // logger.d('CREATE_ACCOUNT');
        account = Account.create(uid: user.uid, protocols: [protocol!]);

        String email = user.email ?? '';
        String display = user.displayName ?? email.split('@').first ?? '';
        account = account.copyWith(
          email: email,
          display: display,
          firstName: display,
          avatar: photoUrl,
        );
        await ref.set(account.toJson());
      }
      return account;
    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  static Future<bool> save(String uid, Map<String, dynamic> data) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(Collection.accounts.name).doc(uid);
      await ref.set(data);
      return true;
    } catch (err, _) {
      logger.e(err);
      return false;
    }
  }

  static Future<bool> addProtocol(String uid, AuthType protocol) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(Collection.accounts.name).doc(uid);
      await ref.update({
        'protocols': FieldValue.arrayUnion([protocol.name])
      });
      return true;
    } catch (err, _) {
      logger.e(err);
      return false;
    }
  }

  static Future<bool> removeProtocol(String uid, AuthType protocol) async {
    try {
      final db = FirebaseFirestore.instance;
      final ref = db.collection(Collection.accounts.name).doc(uid);
      await ref.update({
        'protocols': FieldValue.arrayRemove([protocol.name])
      });
      return true;
    } catch (err, _) {
      logger.e(err);
      return false;
    }
  }
}
