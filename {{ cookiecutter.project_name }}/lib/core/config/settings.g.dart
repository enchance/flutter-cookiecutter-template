// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationSettingsImpl _$$ApplicationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationSettingsImpl(
      darkmode: json['darkmode'] as bool,
      fontsize: json['fontsize'] as String,
      fetchCount: json['fetchCount'] as int? ?? 10,
    );

Map<String, dynamic> _$$ApplicationSettingsImplToJson(
        _$ApplicationSettingsImpl instance) =>
    <String, dynamic>{
      'darkmode': instance.darkmode,
      'fontsize': instance.fontsize,
      'fetchCount': instance.fetchCount,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsHash() => r'25b2d3997eafff817febf18950659961e9f5091a';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
