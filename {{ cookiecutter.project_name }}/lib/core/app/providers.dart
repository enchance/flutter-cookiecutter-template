import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';

part 'providers.g.dart';

/*
* Singletons
* */
@Riverpod(keepAlive: true)
Dio dio(DioRef ref) => Dio();

@Riverpod(keepAlive: true)
SharedPreferences prefs(PrefsRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
PackageInfo packageInfo(PackageInfoRef ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref, {required String prefix}) {
  return FlutterSecureStorage(
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accountName: '${prefix}_secure_storage'),
    webOptions: const WebOptions(),
    lOptions: const LinuxOptions(),
  );
}

final useEmulatorProvider = StateProvider<bool>((_) => throw UnimplementedError());
final roleProvider = StateProvider<Role>((_) => defaultRole);
// final appbarTitleProvider = StateProvider<String>((_) => '');
// final connectionProvider = StateProvider<bool>((_) => true);
