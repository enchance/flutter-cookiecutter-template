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

/// @nodoc
mixin _$SettingsMod {
// Also update `Startup.initPreferences()`, `config/conf.dart`
  bool get darkMode => throw _privateConstructorUsedError;
  FontSizes get fontSize => throw _privateConstructorUsedError;
  bool get lockPortrait => throw _privateConstructorUsedError;
  bool get allowNotifications => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsModCopyWith<SettingsMod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModCopyWith<$Res> {
  factory $SettingsModCopyWith(
          SettingsMod value, $Res Function(SettingsMod) then) =
      _$SettingsModCopyWithImpl<$Res, SettingsMod>;
  @useResult
  $Res call(
      {bool darkMode,
      FontSizes fontSize,
      bool lockPortrait,
      bool allowNotifications});
}

/// @nodoc
class _$SettingsModCopyWithImpl<$Res, $Val extends SettingsMod>
    implements $SettingsModCopyWith<$Res> {
  _$SettingsModCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? fontSize = null,
    Object? lockPortrait = null,
    Object? allowNotifications = null,
  }) {
    return _then(_value.copyWith(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as FontSizes,
      lockPortrait: null == lockPortrait
          ? _value.lockPortrait
          : lockPortrait // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNotifications: null == allowNotifications
          ? _value.allowNotifications
          : allowNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsModImplCopyWith<$Res>
    implements $SettingsModCopyWith<$Res> {
  factory _$$SettingsModImplCopyWith(
          _$SettingsModImpl value, $Res Function(_$SettingsModImpl) then) =
      __$$SettingsModImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool darkMode,
      FontSizes fontSize,
      bool lockPortrait,
      bool allowNotifications});
}

/// @nodoc
class __$$SettingsModImplCopyWithImpl<$Res>
    extends _$SettingsModCopyWithImpl<$Res, _$SettingsModImpl>
    implements _$$SettingsModImplCopyWith<$Res> {
  __$$SettingsModImplCopyWithImpl(
      _$SettingsModImpl _value, $Res Function(_$SettingsModImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? fontSize = null,
    Object? lockPortrait = null,
    Object? allowNotifications = null,
  }) {
    return _then(_$SettingsModImpl(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as FontSizes,
      lockPortrait: null == lockPortrait
          ? _value.lockPortrait
          : lockPortrait // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNotifications: null == allowNotifications
          ? _value.allowNotifications
          : allowNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettingsModImpl extends _SettingsMod {
  const _$SettingsModImpl(
      {this.darkMode = conf.darkMode,
      this.fontSize = conf.fontSize,
      this.lockPortrait = conf.lockPortrait,
      this.allowNotifications = conf.allowNotifications})
      : super._();

// Also update `Startup.initPreferences()`, `config/conf.dart`
  @override
  @JsonKey()
  final bool darkMode;
  @override
  @JsonKey()
  final FontSizes fontSize;
  @override
  @JsonKey()
  final bool lockPortrait;
  @override
  @JsonKey()
  final bool allowNotifications;

  @override
  String toString() {
    return 'SettingsMod(darkMode: $darkMode, fontSize: $fontSize, lockPortrait: $lockPortrait, allowNotifications: $allowNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsModImpl &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.lockPortrait, lockPortrait) ||
                other.lockPortrait == lockPortrait) &&
            (identical(other.allowNotifications, allowNotifications) ||
                other.allowNotifications == allowNotifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, darkMode, fontSize, lockPortrait, allowNotifications);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsModImplCopyWith<_$SettingsModImpl> get copyWith =>
      __$$SettingsModImplCopyWithImpl<_$SettingsModImpl>(this, _$identity);
}

abstract class _SettingsMod extends SettingsMod {
  const factory _SettingsMod(
      {final bool darkMode,
      final FontSizes fontSize,
      final bool lockPortrait,
      final bool allowNotifications}) = _$SettingsModImpl;
  const _SettingsMod._() : super._();

  @override // Also update `Startup.initPreferences()`, `config/conf.dart`
  bool get darkMode;
  @override
  FontSizes get fontSize;
  @override
  bool get lockPortrait;
  @override
  bool get allowNotifications;
  @override
  @JsonKey(ignore: true)
  _$$SettingsModImplCopyWith<_$SettingsModImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
