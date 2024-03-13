import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences prefs(PrefsRef ref) {
  throw UnimplementedError('MISSING_PROVIDER');
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) => Dio();

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accountName: '{{ cookiecutter.project_name }}_secure_storage'),
    webOptions: WebOptions(),
    lOptions: LinuxOptions(),
  );
}

final useEmulatorProvider = StateProvider<bool>((ref) {
  throw UnimplementedError();
});

@Riverpod(keepAlive: true)
class DevLog extends _$DevLog {
  @override
  DevLogMod build() => const DevLogMod();

  void log(String message, String dur) =>
      state = state.copyWith(logs: [...state.logs, '$message $dur']);

  void clear() => state = state.copyWith(logs: []);
}
