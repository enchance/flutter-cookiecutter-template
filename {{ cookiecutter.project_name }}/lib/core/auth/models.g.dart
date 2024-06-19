// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      authTypes: const AuthTypeConverter().fromJson(json['authTypes'] as List),
      mobile: json['mobile'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      avatar: json['avatar'] as String? ?? '',
      username: json['username'] as String? ?? '',
      display: json['display'] as String? ?? '',
      coverProfile: json['coverProfile'] as String? ?? '',
      bannedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['bannedAt'], const TimestampConverter().fromJson),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'authTypes': const AuthTypeConverter().toJson(instance.authTypes),
      'mobile': instance.mobile,
      'role': _$RoleEnumMap[instance.role],
      'avatar': instance.avatar,
      'username': instance.username,
      'display': instance.display,
      'coverProfile': instance.coverProfile,
      'bannedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.bannedAt, const TimestampConverter().toJson),
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
    };

const _$RoleEnumMap = {
  Role.starter: 'starter',
  Role.moderator: 'moderator',
  Role.admin: 'admin',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
