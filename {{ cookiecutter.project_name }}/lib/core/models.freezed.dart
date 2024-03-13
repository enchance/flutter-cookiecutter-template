// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ViewGlobals _$ViewGlobalsFromJson(Map<String, dynamic> json) {
  return _ViewGlobals.fromJson(json);
}

/// @nodoc
mixin _$ViewGlobals {
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ViewGlobalsCopyWith<ViewGlobals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewGlobalsCopyWith<$Res> {
  factory $ViewGlobalsCopyWith(
          ViewGlobals value, $Res Function(ViewGlobals) then) =
      _$ViewGlobalsCopyWithImpl<$Res, ViewGlobals>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$ViewGlobalsCopyWithImpl<$Res, $Val extends ViewGlobals>
    implements $ViewGlobalsCopyWith<$Res> {
  _$ViewGlobalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewGlobalsImplCopyWith<$Res>
    implements $ViewGlobalsCopyWith<$Res> {
  factory _$$ViewGlobalsImplCopyWith(
          _$ViewGlobalsImpl value, $Res Function(_$ViewGlobalsImpl) then) =
      __$$ViewGlobalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$ViewGlobalsImplCopyWithImpl<$Res>
    extends _$ViewGlobalsCopyWithImpl<$Res, _$ViewGlobalsImpl>
    implements _$$ViewGlobalsImplCopyWith<$Res> {
  __$$ViewGlobalsImplCopyWithImpl(
      _$ViewGlobalsImpl _value, $Res Function(_$ViewGlobalsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$ViewGlobalsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ViewGlobalsImpl implements _ViewGlobals {
  const _$ViewGlobalsImpl({required this.title});

  factory _$ViewGlobalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewGlobalsImplFromJson(json);

  @override
  final String title;

  @override
  String toString() {
    return 'ViewGlobals(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewGlobalsImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewGlobalsImplCopyWith<_$ViewGlobalsImpl> get copyWith =>
      __$$ViewGlobalsImplCopyWithImpl<_$ViewGlobalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewGlobalsImplToJson(
      this,
    );
  }
}

abstract class _ViewGlobals implements ViewGlobals {
  const factory _ViewGlobals({required final String title}) = _$ViewGlobalsImpl;

  factory _ViewGlobals.fromJson(Map<String, dynamic> json) =
      _$ViewGlobalsImpl.fromJson;

  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$ViewGlobalsImplCopyWith<_$ViewGlobalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DevLogMod {
  List<String> get logs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DevLogModCopyWith<DevLogMod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevLogModCopyWith<$Res> {
  factory $DevLogModCopyWith(DevLogMod value, $Res Function(DevLogMod) then) =
      _$DevLogModCopyWithImpl<$Res, DevLogMod>;
  @useResult
  $Res call({List<String> logs});
}

/// @nodoc
class _$DevLogModCopyWithImpl<$Res, $Val extends DevLogMod>
    implements $DevLogModCopyWith<$Res> {
  _$DevLogModCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logs = null,
  }) {
    return _then(_value.copyWith(
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevLogModImplCopyWith<$Res>
    implements $DevLogModCopyWith<$Res> {
  factory _$$DevLogModImplCopyWith(
          _$DevLogModImpl value, $Res Function(_$DevLogModImpl) then) =
      __$$DevLogModImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> logs});
}

/// @nodoc
class __$$DevLogModImplCopyWithImpl<$Res>
    extends _$DevLogModCopyWithImpl<$Res, _$DevLogModImpl>
    implements _$$DevLogModImplCopyWith<$Res> {
  __$$DevLogModImplCopyWithImpl(
      _$DevLogModImpl _value, $Res Function(_$DevLogModImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logs = null,
  }) {
    return _then(_$DevLogModImpl(
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DevLogModImpl implements _DevLogMod {
  const _$DevLogModImpl({final List<String> logs = const []}) : _logs = logs;

  final List<String> _logs;
  @override
  @JsonKey()
  List<String> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  String toString() {
    return 'DevLogMod(logs: $logs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevLogModImpl &&
            const DeepCollectionEquality().equals(other._logs, _logs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_logs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevLogModImplCopyWith<_$DevLogModImpl> get copyWith =>
      __$$DevLogModImplCopyWithImpl<_$DevLogModImpl>(this, _$identity);
}

abstract class _DevLogMod implements DevLogMod {
  const factory _DevLogMod({final List<String> logs}) = _$DevLogModImpl;

  @override
  List<String> get logs;
  @override
  @JsonKey(ignore: true)
  _$$DevLogModImplCopyWith<_$DevLogModImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
