// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigModImpl _$$ConfigModImplFromJson(Map<String, dynamic> json) =>
    _$ConfigModImpl(
      darkMode: json['darkMode'] as bool? ?? defaultDarkMode,
      fetchCount: (json['fetchCount'] as num?)?.toInt() ?? defaultFetchCount,
      textSize: $enumDecodeNullable(_$TextSizeEnumMap, json['textSize']) ??
          defaultTextSize,
      gridSize: json['gridSize'] == null
          ? defaultGridSize
          : const GridSizeConverter().fromJson(json['gridSize'] as String),
    );

Map<String, dynamic> _$$ConfigModImplToJson(_$ConfigModImpl instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'fetchCount': instance.fetchCount,
      'textSize': _$TextSizeEnumMap[instance.textSize]!,
      'gridSize': const GridSizeConverter().toJson(instance.gridSize),
    };

const _$TextSizeEnumMap = {
  TextSize.small: 'small',
  TextSize.medium: 'medium',
  TextSize.large: 'large',
  TextSize.xlarge: 'xlarge',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsHash() => r'ef426a67dc00153d28a80bd094019e370f9b1346';

/// See also [settings].
@ProviderFor(settings)
final settingsProvider = Provider<Settings>.internal(
  settings,
  name: r'settingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SettingsRef = ProviderRef<Settings>;
String _$appConfigHash() => r'cbdb098daf374b46045fe9172f61356c49c2616b';

/// Modify config values.
///
/// Copied from [AppConfig].
@ProviderFor(AppConfig)
final appConfigProvider =
    AutoDisposeNotifierProvider<AppConfig, ConfigMod>.internal(
  AppConfig.new,
  name: r'appConfigProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppConfig = AutoDisposeNotifier<ConfigMod>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
