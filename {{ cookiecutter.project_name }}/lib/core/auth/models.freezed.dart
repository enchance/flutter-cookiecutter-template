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

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstname => throw _privateConstructorUsedError;
  String get lastname => throw _privateConstructorUsedError;
  @AuthTypeConverter()
  List<AuthType> get authTypes => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  Role? get role => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get display => throw _privateConstructorUsedError;
  String get coverProfile =>
      throw _privateConstructorUsedError; // @Default('') final String linkedAccount,
  @TimestampConverter()
  DateTime? get bannedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String firstname,
      String lastname,
      @AuthTypeConverter() List<AuthType> authTypes,
      String? mobile,
      Role? role,
      String avatar,
      String username,
      String display,
      String coverProfile,
      @TimestampConverter() DateTime? bannedAt,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? authTypes = null,
    Object? mobile = freezed,
    Object? role = freezed,
    Object? avatar = null,
    Object? username = null,
    Object? display = null,
    Object? coverProfile = null,
    Object? bannedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      authTypes: null == authTypes
          ? _value.authTypes
          : authTypes // ignore: cast_nullable_to_non_nullable
              as List<AuthType>,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role?,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String,
      coverProfile: null == coverProfile
          ? _value.coverProfile
          : coverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(
          _$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String firstname,
      String lastname,
      @AuthTypeConverter() List<AuthType> authTypes,
      String? mobile,
      Role? role,
      String avatar,
      String username,
      String display,
      String coverProfile,
      @TimestampConverter() DateTime? bannedAt,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(
      _$AccountImpl _value, $Res Function(_$AccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? authTypes = null,
    Object? mobile = freezed,
    Object? role = freezed,
    Object? avatar = null,
    Object? username = null,
    Object? display = null,
    Object? coverProfile = null,
    Object? bannedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AccountImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      authTypes: null == authTypes
          ? _value._authTypes
          : authTypes // ignore: cast_nullable_to_non_nullable
              as List<AuthType>,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role?,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String,
      coverProfile: null == coverProfile
          ? _value.coverProfile
          : coverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountImpl extends _Account {
  const _$AccountImpl(
      {this.uid = '',
      required this.email,
      required this.firstname,
      required this.lastname,
      @AuthTypeConverter() required final List<AuthType> authTypes,
      this.mobile,
      this.role,
      this.avatar = '',
      this.username = '',
      this.display = '',
      this.coverProfile = '',
      @TimestampConverter() required this.bannedAt,
      @TimestampConverter() required this.createdAt})
      : _authTypes = authTypes,
        super._();

  factory _$AccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountImplFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  final String email;
  @override
  final String firstname;
  @override
  final String lastname;
  final List<AuthType> _authTypes;
  @override
  @AuthTypeConverter()
  List<AuthType> get authTypes {
    if (_authTypes is EqualUnmodifiableListView) return _authTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authTypes);
  }

  @override
  final String? mobile;
  @override
  final Role? role;
  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String display;
  @override
  @JsonKey()
  final String coverProfile;
// @Default('') final String linkedAccount,
  @override
  @TimestampConverter()
  final DateTime? bannedAt;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Account(uid: $uid, email: $email, firstname: $firstname, lastname: $lastname, authTypes: $authTypes, mobile: $mobile, role: $role, avatar: $avatar, username: $username, display: $display, coverProfile: $coverProfile, bannedAt: $bannedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            const DeepCollectionEquality()
                .equals(other._authTypes, _authTypes) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.display, display) || other.display == display) &&
            (identical(other.coverProfile, coverProfile) ||
                other.coverProfile == coverProfile) &&
            (identical(other.bannedAt, bannedAt) ||
                other.bannedAt == bannedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      firstname,
      lastname,
      const DeepCollectionEquality().hash(_authTypes),
      mobile,
      role,
      avatar,
      username,
      display,
      coverProfile,
      bannedAt,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountImplToJson(
      this,
    );
  }
}

abstract class _Account extends Account {
  const factory _Account(
          {final String uid,
          required final String email,
          required final String firstname,
          required final String lastname,
          @AuthTypeConverter() required final List<AuthType> authTypes,
          final String? mobile,
          final Role? role,
          final String avatar,
          final String username,
          final String display,
          final String coverProfile,
          @TimestampConverter() required final DateTime? bannedAt,
          @TimestampConverter() required final DateTime? createdAt}) =
      _$AccountImpl;
  const _Account._() : super._();

  factory _Account.fromJson(Map<String, dynamic> json) = _$AccountImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String get firstname;
  @override
  String get lastname;
  @override
  @AuthTypeConverter()
  List<AuthType> get authTypes;
  @override
  String? get mobile;
  @override
  Role? get role;
  @override
  String get avatar;
  @override
  String get username;
  @override
  String get display;
  @override
  String get coverProfile;
  @override // @Default('') final String linkedAccount,
  @TimestampConverter()
  DateTime? get bannedAt;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
