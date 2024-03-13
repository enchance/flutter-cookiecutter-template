import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';
import '../config/conf.dart' as conf;
import '../../firebase_options.dart';

class StartupService {
  /// Run all setup requirements before starting the app. This is where you can make queries
  /// to firestore, auth, or any other service you might be using before the app starts
  static Future<Account?> initialize(dynamic ref, UserCredential creds) async {
    User? user = creds.user;
    if(user == null) {
      ref.read(authProvider.notifier).signOut();
      logger.e('Signing out: account == null. No user.');
    }

    // Stopwatch stopwatch = Stopwatch();
    // final FlutterSecureStorage secstor = ref.watch(secureStorageProvider);

    // logger.d(await secstor.readAll());
    // await secstor.deleteAll();
    // await Future.delayed(const Duration(seconds: 9999));

    // bool isConnected = await InternetConnectionChecker().hasConnection;
    try {
      // stopwatch.start();
      // final accountKey = 'account-${user.uid}';
      // String accountStr = await secstor.read(key: accountKey) ?? '';
      // Map<String, dynamic> accountMap = accountStr.isEmpty ? {} : json.decode(accountStr);

      // Check online instead of this way
      String photoUrl = creds.additionalUserInfo?.profile?['picture'] ?? '';
      Account? account = await AccountService.getAndCreate(user: user!, photoUrl: photoUrl);
      // ref.read(devLogProvider.notifier).log('[ACCOUNT_FETCH]', roundoff(stopwatch));
      if (account == null) {
        ref.read(authProvider.notifier).signOut();
        logger.e('Signing out: account == null. No user ${user.uid} in database.');
      }

      // stopwatch
      //   ..reset()
      //   ..start();
      ref.read(userAccountProvider.notifier).save(account);
      // ref.read(devLogProvider.notifier).log('[USER_ACCOUNT_SAVE]', roundoff(stopwatch));

      // final Account? account = await AccountService.getFromStorage(secstor, accountMap, accountKey,
      //     isConnected: isConnected);

      // Success
      ref.read(startupCompleteProvider.notifier).update((state) => true);
      // logger.d(ref.watch(devLogProvider).logs);

      return account;

    } catch (err, _) {
      logger.e(err);
      return null;
    }
  }

  static Future<void> initFirebase(bool useEmulator) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kDebugMode && useEmulator) {
      // Emulator
      FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
      FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
      FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
    } else {
      // Appcheck
      await FirebaseAppCheck.instance.activate(
        androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
        // TODO: Enable for apple
        // appleProvider: AppleProvider.appAttest,
      );
    }
  }

  static Future<SharedPreferences> initPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // prefs.clear();

      // Populate prefs if they don't exist
      await prefs.getAndSave<bool>(Setting.darkMode, conf.darkMode);
      await prefs.getAndSave<String>(Setting.fontSize, conf.fontSize.name);
      await prefs.getAndSave<bool>(Setting.lockPortrait, conf.lockPortrait);
      await prefs.getAndSave<bool>(Setting.allowNotifications, conf.allowNotifications);
      return prefs;
    } catch (err, _) {
      logger.d(err);
      rethrow;
    }
  }
}
