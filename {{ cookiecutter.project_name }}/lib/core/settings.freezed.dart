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

ConfigMod _$ConfigModFromJson(Map<String, dynamic> json) {
  return _ConfigMod.fromJson(json);
}

/// @nodoc
mixin _$ConfigMod {
  bool get darkMode => throw _privateConstructorUsedError;
  int get fetchCount => throw _privateConstructorUsedError;
  TextSize get textSize => throw _privateConstructorUsedError;
  @GridSizeConverter()
  GridSize get gridSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigModCopyWith<ConfigMod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigModCopyWith<$Res> {
  factory $ConfigModCopyWith(ConfigMod value, $Res Function(ConfigMod) then) =
      _$ConfigModCopyWithImpl<$Res, ConfigMod>;
  @useResult
  $Res call(
      {bool darkMode,
      int fetchCount,
      TextSize textSize,
      @GridSizeConverter() GridSize gridSize});
}

/// @nodoc
class _$ConfigModCopyWithImpl<$Res, $Val extends ConfigMod>
    implements $ConfigModCopyWith<$Res> {
  _$ConfigModCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? fetchCount = null,
    Object? textSize = null,
    Object? gridSize = null,
  }) {
    return _then(_value.copyWith(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fetchCount: null == fetchCount
          ? _value.fetchCount
          : fetchCount // ignore: cast_nullable_to_non_nullable
              as int,
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as TextSize,
      gridSize: null == gridSize
          ? _value.gridSize
          : gridSize // ignore: cast_nullable_to_non_nullable
              as GridSize,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigModImplCopyWith<$Res>
    implements $ConfigModCopyWith<$Res> {
  factory _$$ConfigModImplCopyWith(
          _$ConfigModImpl value, $Res Function(_$ConfigModImpl) then) =
      __$$ConfigModImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool darkMode,
      int fetchCount,
      TextSize textSize,
      @GridSizeConverter() GridSize gridSize});
}

/// @nodoc
class __$$ConfigModImplCopyWithImpl<$Res>
    extends _$ConfigModCopyWithImpl<$Res, _$ConfigModImpl>
    implements _$$ConfigModImplCopyWith<$Res> {
  __$$ConfigModImplCopyWithImpl(
      _$ConfigModImpl _value, $Res Function(_$ConfigModImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? fetchCount = null,
    Object? textSize = null,
    Object? gridSize = null,
  }) {
    return _then(_$ConfigModImpl(
      darkMode: null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fetchCount: null == fetchCount
          ? _value.fetchCount
          : fetchCount // ignore: cast_nullable_to_non_nullable
              as int,
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as TextSize,
      gridSize: null == gridSize
          ? _value.gridSize
          : gridSize // ignore: cast_nullable_to_non_nullable
              as GridSize,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigModImpl implements _ConfigMod {
  const _$ConfigModImpl(
      {this.darkMode = defaultDarkMode,
      this.fetchCount = defaultFetchCount,
      this.textSize = defaultTextSize,
      @GridSizeConverter() this.gridSize = defaultGridSize});

  factory _$ConfigModImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigModImplFromJson(json);

  @override
  @JsonKey()
  final bool darkMode;
  @override
  @JsonKey()
  final int fetchCount;
  @override
  @JsonKey()
  final TextSize textSize;
  @override
  @JsonKey()
  @GridSizeConverter()
  final GridSize gridSize;

  @override
  String toString() {
    return 'ConfigMod(darkMode: $darkMode, fetchCount: $fetchCount, textSize: $textSize, gridSize: $gridSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigModImpl &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.fetchCount, fetchCount) ||
                other.fetchCount == fetchCount) &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.gridSize, gridSize) ||
                other.gridSize == gridSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, darkMode, fetchCount, textSize, gridSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigModImplCopyWith<_$ConfigModImpl> get copyWith =>
      __$$ConfigModImplCopyWithImpl<_$ConfigModImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigModImplToJson(
      this,
    );
  }
}

abstract class _ConfigMod implements ConfigMod {
  const factory _ConfigMod(
      {final bool darkMode,
      final int fetchCount,
      final TextSize textSize,
      @GridSizeConverter() final GridSize gridSize}) = _$ConfigModImpl;

  factory _ConfigMod.fromJson(Map<String, dynamic> json) =
      _$ConfigModImpl.fromJson;

  @override
  bool get darkMode;
  @override
  int get fetchCount;
  @override
  TextSize get textSize;
  @override
  @GridSizeConverter()
  GridSize get gridSize;
  @override
  @JsonKey(ignore: true)
  _$$ConfigModImplCopyWith<_$ConfigModImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
