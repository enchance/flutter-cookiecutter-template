// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prefsHash() => r'24f580c638f68cd66ff398f7394d6688f4a4338c';

/// See also [prefs].
@ProviderFor(prefs)
final prefsProvider = Provider<SharedPreferences>.internal(
  prefs,
  name: r'prefsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$prefsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PrefsRef = ProviderRef<SharedPreferences>;
String _$dioHash() => r'41b696b35e5b56ccb124ee5abab8b893747d2153';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = ProviderRef<Dio>;
String _$secureStorageHash() => r'b9aa0fdfa39ba38925e836e0f8a44c05863ee48a';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$devLogHash() => r'fdbc491351b781b8855b7badfa8a1e9a90a49990';

/// See also [DevLog].
@ProviderFor(DevLog)
final devLogProvider = NotifierProvider<DevLog, DevLogMod>.internal(
  DevLog.new,
  name: r'devLogProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$devLogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DevLog = Notifier<DevLogMod>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
