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
  String? get id => throw _privateConstructorUsedError;
  @NullConverter()
  String get email => throw _privateConstructorUsedError;
  String get fullname => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get display => throw _privateConstructorUsedError;
  @NullConverter()
  String get username => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  @AuthTypeConverter()
  Set<AuthType> get providers => throw _privateConstructorUsedError;
  @RolesConverter()
  Set<Role> get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_id')
  String get providerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_profile')
  String get coverProfile => throw _privateConstructorUsedError;
  @JsonKey(name: 'banned_at')
  DateTime? get bannedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
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
      {String? id,
      @NullConverter() String email,
      String fullname,
      String phone,
      String avatar,
      String display,
      @NullConverter() String username,
      String gender,
      String status,
      DateTime? birthday,
      @AuthTypeConverter() Set<AuthType> providers,
      @RolesConverter() Set<Role> roles,
      @JsonKey(name: 'provider_id') String providerId,
      @JsonKey(name: 'cover_profile') String coverProfile,
      @JsonKey(name: 'banned_at') DateTime? bannedAt,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
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
    Object? id = freezed,
    Object? email = null,
    Object? fullname = null,
    Object? phone = null,
    Object? avatar = null,
    Object? display = null,
    Object? username = null,
    Object? gender = null,
    Object? status = null,
    Object? birthday = freezed,
    Object? providers = null,
    Object? roles = null,
    Object? providerId = null,
    Object? coverProfile = null,
    Object? bannedAt = freezed,
    Object? deletedAt = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullname: null == fullname
          ? _value.fullname
          : fullname // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providers: null == providers
          ? _value.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as Set<AuthType>,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Set<Role>,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      coverProfile: null == coverProfile
          ? _value.coverProfile
          : coverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
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
      {String? id,
      @NullConverter() String email,
      String fullname,
      String phone,
      String avatar,
      String display,
      @NullConverter() String username,
      String gender,
      String status,
      DateTime? birthday,
      @AuthTypeConverter() Set<AuthType> providers,
      @RolesConverter() Set<Role> roles,
      @JsonKey(name: 'provider_id') String providerId,
      @JsonKey(name: 'cover_profile') String coverProfile,
      @JsonKey(name: 'banned_at') DateTime? bannedAt,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
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
    Object? id = freezed,
    Object? email = null,
    Object? fullname = null,
    Object? phone = null,
    Object? avatar = null,
    Object? display = null,
    Object? username = null,
    Object? gender = null,
    Object? status = null,
    Object? birthday = freezed,
    Object? providers = null,
    Object? roles = null,
    Object? providerId = null,
    Object? coverProfile = null,
    Object? bannedAt = freezed,
    Object? deletedAt = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AccountImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullname: null == fullname
          ? _value.fullname
          : fullname // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providers: null == providers
          ? _value._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as Set<AuthType>,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Set<Role>,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      coverProfile: null == coverProfile
          ? _value.coverProfile
          : coverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      bannedAt: freezed == bannedAt
          ? _value.bannedAt
          : bannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
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
      {this.id,
      @NullConverter() required this.email,
      required this.fullname,
      required this.phone,
      this.avatar = '',
      this.display = '',
      @NullConverter() this.username = '',
      this.gender = '',
      this.status = '',
      this.birthday,
      @AuthTypeConverter() required final Set<AuthType> providers,
      @RolesConverter() required final Set<Role> roles,
      @JsonKey(name: 'provider_id') this.providerId = '',
      @JsonKey(name: 'cover_profile') this.coverProfile = '',
      @JsonKey(name: 'banned_at') this.bannedAt,
      @JsonKey(name: 'deleted_at') this.deletedAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'created_at') this.createdAt})
      : _providers = providers,
        _roles = roles,
        super._();

  factory _$AccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountImplFromJson(json);

  @override
  final String? id;
  @override
  @NullConverter()
  final String email;
  @override
  final String fullname;
  @override
  final String phone;
  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final String display;
  @override
  @JsonKey()
  @NullConverter()
  final String username;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? birthday;
  final Set<AuthType> _providers;
  @override
  @AuthTypeConverter()
  Set<AuthType> get providers {
    if (_providers is EqualUnmodifiableSetView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_providers);
  }

  final Set<Role> _roles;
  @override
  @RolesConverter()
  Set<Role> get roles {
    if (_roles is EqualUnmodifiableSetView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_roles);
  }

  @override
  @JsonKey(name: 'provider_id')
  final String providerId;
  @override
  @JsonKey(name: 'cover_profile')
  final String coverProfile;
  @override
  @JsonKey(name: 'banned_at')
  final DateTime? bannedAt;
  @override
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Account(id: $id, email: $email, fullname: $fullname, phone: $phone, avatar: $avatar, display: $display, username: $username, gender: $gender, status: $status, birthday: $birthday, providers: $providers, roles: $roles, providerId: $providerId, coverProfile: $coverProfile, bannedAt: $bannedAt, deletedAt: $deletedAt, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullname, fullname) ||
                other.fullname == fullname) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.display, display) || other.display == display) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            const DeepCollectionEquality()
                .equals(other._providers, _providers) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.coverProfile, coverProfile) ||
                other.coverProfile == coverProfile) &&
            (identical(other.bannedAt, bannedAt) ||
                other.bannedAt == bannedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      fullname,
      phone,
      avatar,
      display,
      username,
      gender,
      status,
      birthday,
      const DeepCollectionEquality().hash(_providers),
      const DeepCollectionEquality().hash(_roles),
      providerId,
      coverProfile,
      bannedAt,
      deletedAt,
      updatedAt,
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
      {final String? id,
      @NullConverter() required final String email,
      required final String fullname,
      required final String phone,
      final String avatar,
      final String display,
      @NullConverter() final String username,
      final String gender,
      final String status,
      final DateTime? birthday,
      @AuthTypeConverter() required final Set<AuthType> providers,
      @RolesConverter() required final Set<Role> roles,
      @JsonKey(name: 'provider_id') final String providerId,
      @JsonKey(name: 'cover_profile') final String coverProfile,
      @JsonKey(name: 'banned_at') final DateTime? bannedAt,
      @JsonKey(name: 'deleted_at') final DateTime? deletedAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'created_at') final DateTime? createdAt}) = _$AccountImpl;
  const _Account._() : super._();

  factory _Account.fromJson(Map<String, dynamic> json) = _$AccountImpl.fromJson;

  @override
  String? get id;
  @override
  @NullConverter()
  String get email;
  @override
  String get fullname;
  @override
  String get phone;
  @override
  String get avatar;
  @override
  String get display;
  @override
  @NullConverter()
  String get username;
  @override
  String get gender;
  @override
  String get status;
  @override
  DateTime? get birthday;
  @override
  @AuthTypeConverter()
  Set<AuthType> get providers;
  @override
  @RolesConverter()
  Set<Role> get roles;
  @override
  @JsonKey(name: 'provider_id')
  String get providerId;
  @override
  @JsonKey(name: 'cover_profile')
  String get coverProfile;
  @override
  @JsonKey(name: 'banned_at')
  DateTime? get bannedAt;
  @override
  @JsonKey(name: 'deleted_at')
  DateTime? get deletedAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
