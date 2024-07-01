import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core.dart';

class AccountService {
  AccountService._();

  static Future<bool> save(String id, PostgrestMap datamap) async {
    final supabase = Supabase.instance.client;

    try {
      datamap = stripImmutableFields(datamap);
      await supabase.from('auth_accounts').update(datamap).eq('id', id);
      return true;
    } catch (err, _) {
      return false;
    }
  }

  /// Get the account record for [uid] from Firestore if exists else create it.
  static Future<Account?> fetchOrCreate(User user, [AuthResponse? authres]) async {
    try {
      Account? account = await fetchAccount(user.id, authres);
      if (account == null) {
        logger.d('CREATE_ACCOUNT');

        final email = user.email!;
        final (firstname, lastname) = splitName(email);
        final fullname = '$firstname $lastname'.trim();
        final display = parseDisplayName(fullname);
        final provider = guessProvider(user);

        account = Account.create(
          display: display,
          fullname: fullname,
          email: email,
          avatar: '',
          phone: user.phone ?? '',
          provider: provider,
        );
        account = await insert(account.toJson());
      }
      return account;
    } catch (err, _) {
      logger.e(err);;
      return null;
    }
  }

  static Future<Account?> insert(PostgrestMap datamap) async {
    final supabase = Supabase.instance.client;
    try {
      datamap = stripImmutableFields(datamap);
      datamap = await supabase.from('auth_accounts').insert(datamap).select().single();
      logger.d('[INSERTED]');

      return Account.fromJson(datamap);
    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  static Future<Account?> fetchAccount(String id, [AuthResponse? authres]) async {
    final supabase = Supabase.instance.client;

    try {
      final datamap = await supabase.from('auth_accounts').select().eq('id', id).maybeSingle();
      logger.d('[FETCHED]');
      if (datamap == null) throw RowNotFoundException();
      final account = Account.fromJson(datamap);
      return account;
    } on RowNotFoundException {
      return null;
    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  static AuthType guessProvider(User user) {
    if (user.isAnonymous) return AuthType.anonymous;
    if(user.appMetadata['provider'] == 'email') return AuthType.email;
    if(user.appMetadata['provider'] == 'google') return AuthType.google;
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

  // static Future<bool> addAuthType(String id, AuthType authType) async {
  //   final client = Supabase.instance.client;
  //
  //   try {
  //     // final db = FirebaseFirestore.instance;
  //     // final ref = db.collection(C8n.accounts.name).doc(uid);
  //     await client.from('user').update({
  //       'auth_types': client.rpc('array_append', params: {
  //         'auth_types': 'existing_value',
  //
  //       }),
  //     });
  //     // await ref.update({
  //     //   'authTypes': FieldValue.arrayUnion([authType.name])
  //     // });
  //     return true;
  //   } catch (err, _) {
  //     logger.e(err);
  //     return false;
  //   }
  // }

  // static Future<void> changeEmail(User? user, String newEmail) async {
  //   if (user == null) throw UserNullException();
  //
  //   try {
  //     await user.verifyBeforeUpdateEmail(newEmail);
  //   } catch (err, _) {
  //     logger.e(err);
  //     rethrow;
  //   }
  // }


}
