import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class ViewGlobals with _$ViewGlobals {
  const factory ViewGlobals({
    required String title,
  }) = _ViewGlobals;

  factory ViewGlobals.fromJson(Map<String, Object?> json) => _$ViewGlobalsFromJson(json);
}

@freezed
class DevLogMod with _$DevLogMod {
  const factory DevLogMod({
    @Default([]) List<String> logs,
  }) = _DevLogMod;

  // factory DevLogMod.fromJson(Map<String, Object?> json) => _$DevLogModFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp ts) => ts.toDate();

  @override
  Timestamp toJson(DateTime dt) => Timestamp.fromDate(dt);
}

class RoleConverter implements JsonConverter<Role, String> {
  const RoleConverter();

  @override
  Role fromJson(String role) {
    try {
      return Role.values.byName(role);
    } catch (err, _) {
      return defaultRole;
    }
  }

  @override
  String toJson(Role role) => role.name;
}

class AuthTypeConverter implements JsonConverter<List<AuthType>, List> {
  const AuthTypeConverter();

  @override
  List<AuthType> fromJson(List protocols) {
    return protocols.map((item) => AuthType.values.byName(item as String)).toList();
  }

  @override
  List toJson(List<AuthType> protocols) {
    return protocols.map((item) => item.name).toList();
  }
}
