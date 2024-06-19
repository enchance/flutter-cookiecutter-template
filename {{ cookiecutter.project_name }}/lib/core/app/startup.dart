import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';
import '../core.dart';

class Startup {
  static Future<void> initFirebase(bool useEmulator) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Remote Config
    final remoteConf = FirebaseRemoteConfig.instance;
    await remoteConf.setConfigSettings(RemoteConfigSettings(
      // PROD: Change minimumFetchInterval (12h) + fetchTimeout (1m)
      minimumFetchInterval: const Duration(minutes: 5),
      fetchTimeout: const Duration(minutes: 1),
    ));
    // await remoteConf.setDefaults(remoteConfDefaults);

    // Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

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
        appleProvider: AppleProvider.appAttest,
      );
    }
  }

  /// Set default values for config after **user signs in**.
  /// These values will be overwritten once user has signed in.
  static Future<ConfigMod> initConfig(SharedPreferences prefs) async {
    const def = ConfigMod();

    final darkMode = prefKey('darkMode');
    if (!prefs.containsKey(darkMode)) await prefs.setBool(darkMode, def.darkMode);

    final textSize = prefKey('textSize');
    if (!prefs.containsKey(textSize)) await prefs.setString(textSize, def.textSize.name);

    final fetchCount = prefKey('fetchCount');
    if (!prefs.containsKey(fetchCount)) await prefs.setInt(fetchCount, def.fetchCount);

    final gridSize = prefKey('gridSize');
    if (!prefs.containsKey(gridSize)) await prefs.setString(gridSize, def.gridSize.name);

    return ConfigMod(
      darkMode: prefs.getBool(darkMode)!,
      textSize: TextSize.values.byName(prefs.getString(textSize)!),
      fetchCount: prefs.getInt(fetchCount)!,
      gridSize: GridSize.values.byName(prefs.getString(gridSize)!),
    );
  }
}
