// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: json['id'] as String?,
      email: const NullConverter().fromJson(json['email'] as String?),
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String? ?? '',
      display: json['display'] as String? ?? '',
      username: json['username'] == null
          ? ''
          : const NullConverter().fromJson(json['username'] as String?),
      gender: json['gender'] as String? ?? '',
      status: json['status'] as String? ?? '',
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      providers: const AuthTypeConverter().fromJson(json['providers'] as List),
      roles: const RolesConverter().fromJson(json['roles'] as List),
      providerId: json['provider_id'] as String? ?? '',
      coverProfile: json['cover_profile'] as String? ?? '',
      bannedAt: json['banned_at'] == null
          ? null
          : DateTime.parse(json['banned_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': const NullConverter().toJson(instance.email),
      'fullname': instance.fullname,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'display': instance.display,
      'username': const NullConverter().toJson(instance.username),
      'gender': instance.gender,
      'status': instance.status,
      'birthday': instance.birthday?.toIso8601String(),
      'providers': const AuthTypeConverter().toJson(instance.providers),
      'roles': const RolesConverter().toJson(instance.roles),
      'provider_id': instance.providerId,
      'cover_profile': instance.coverProfile,
      'banned_at': instance.bannedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
