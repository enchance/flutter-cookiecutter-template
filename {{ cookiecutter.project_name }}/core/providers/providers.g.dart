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
String _$appSettingsHash() => r'58649dc14db0fcaf35c30deccfe4e245900c484a';

/// Provider for app settings. Create methods that replace [state] here.
/// Don't put methods in [ApplicationSettings] since you don't have
/// access to [state] there but you do here.
///
/// Copied from [AppSettings].
@ProviderFor(AppSettings)
final appSettingsProvider =
    NotifierProvider<AppSettings, ApplicationSettings>.internal(
  AppSettings.new,
  name: r'appSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppSettings = Notifier<ApplicationSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
