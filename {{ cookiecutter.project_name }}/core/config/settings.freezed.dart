// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplicationSettings _$ApplicationSettingsFromJson(Map<String, dynamic> json) {
  return _ApplicationSettings.fromJson(json);
}

/// @nodoc
mixin _$ApplicationSettings {
  bool get darkmode => throw _privateConstructorUsedError;
  String get fontsize => throw _privateConstructorUsedError;
  int get fetchCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplicationSettingsCopyWith<ApplicationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationSettingsCopyWith<$Res> {
  factory $ApplicationSettingsCopyWith(
          ApplicationSettings value, $Res Function(ApplicationSettings) then) =
      _$ApplicationSettingsCopyWithImpl<$Res, ApplicationSettings>;
  @useResult
  $Res call({bool darkmode, String fontsize, int fetchCount});
}

/// @nodoc
class _$ApplicationSettingsCopyWithImpl<$Res, $Val extends ApplicationSettings>
    implements $ApplicationSettingsCopyWith<$Res> {
  _$ApplicationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkmode = null,
    Object? fontsize = null,
    Object? fetchCount = null,
  }) {
    return _then(_value.copyWith(
      darkmode: null == darkmode
          ? _value.darkmode
          : darkmode // ignore: cast_nullable_to_non_nullable
              as bool,
      fontsize: null == fontsize
          ? _value.fontsize
          : fontsize // ignore: cast_nullable_to_non_nullable
              as String,
      fetchCount: null == fetchCount
          ? _value.fetchCount
          : fetchCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationSettingsImplCopyWith<$Res>
    implements $ApplicationSettingsCopyWith<$Res> {
  factory _$$ApplicationSettingsImplCopyWith(_$ApplicationSettingsImpl value,
          $Res Function(_$ApplicationSettingsImpl) then) =
      __$$ApplicationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool darkmode, String fontsize, int fetchCount});
}

/// @nodoc
class __$$ApplicationSettingsImplCopyWithImpl<$Res>
    extends _$ApplicationSettingsCopyWithImpl<$Res, _$ApplicationSettingsImpl>
    implements _$$ApplicationSettingsImplCopyWith<$Res> {
  __$$ApplicationSettingsImplCopyWithImpl(_$ApplicationSettingsImpl _value,
      $Res Function(_$ApplicationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkmode = null,
    Object? fontsize = null,
    Object? fetchCount = null,
  }) {
    return _then(_$ApplicationSettingsImpl(
      darkmode: null == darkmode
          ? _value.darkmode
          : darkmode // ignore: cast_nullable_to_non_nullable
              as bool,
      fontsize: null == fontsize
          ? _value.fontsize
          : fontsize // ignore: cast_nullable_to_non_nullable
              as String,
      fetchCount: null == fetchCount
          ? _value.fetchCount
          : fetchCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationSettingsImpl implements _ApplicationSettings {
  const _$ApplicationSettingsImpl(
      {required this.darkmode, required this.fontsize, this.fetchCount = 10});

  factory _$ApplicationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationSettingsImplFromJson(json);

  @override
  final bool darkmode;
  @override
  final String fontsize;
  @override
  @JsonKey()
  final int fetchCount;

  @override
  String toString() {
    return 'ApplicationSettings(darkmode: $darkmode, fontsize: $fontsize, fetchCount: $fetchCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationSettingsImpl &&
            (identical(other.darkmode, darkmode) ||
                other.darkmode == darkmode) &&
            (identical(other.fontsize, fontsize) ||
                other.fontsize == fontsize) &&
            (identical(other.fetchCount, fetchCount) ||
                other.fetchCount == fetchCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, darkmode, fontsize, fetchCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationSettingsImplCopyWith<_$ApplicationSettingsImpl> get copyWith =>
      __$$ApplicationSettingsImplCopyWithImpl<_$ApplicationSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationSettingsImplToJson(
      this,
    );
  }
}

abstract class _ApplicationSettings implements ApplicationSettings {
  const factory _ApplicationSettings(
      {required final bool darkmode,
      required final String fontsize,
      final int fetchCount}) = _$ApplicationSettingsImpl;

  factory _ApplicationSettings.fromJson(Map<String, dynamic> json) =
      _$ApplicationSettingsImpl.fromJson;

  @override
  bool get darkmode;
  @override
  String get fontsize;
  @override
  int get fetchCount;
  @override
  @JsonKey(ignore: true)
  _$$ApplicationSettingsImplCopyWith<_$ApplicationSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
