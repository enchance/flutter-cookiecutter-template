import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    @Default('') String uid,
    required final String email,
    required final String fullname,
    @AuthTypeConverter() required final List<AuthType> authTypes,
    final String? phone,
    final Role? role,
    @Default('') final String avatar,
    @Default('') final String username,
    @Default('') final String display,
    @Default('') final String coverProfile,
    @TimestampConverter() required DateTime? bannedAt,
    @TimestampConverter() required DateTime? createdAt,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) => _$AccountFromJson(json);

  factory Account.create({
    required String uid,
    required AuthType authType,
    String? email,
    String? fullname,
    String? phone,
    String? display,
    String? avatar,
    Role role = defaultRole,
  }) {
    final (firstname, _) = splitName(fullname ?? '');
    return Account(
      uid: uid,
      email: email ?? '',
      fullname: fullname ?? firstname,
      authTypes: [authType],
      phone: phone ?? '',
      display: display ?? firstname,
      role: role,
      avatar: avatar ?? '',
      bannedAt: null,
      createdAt: DateTime.now(),
    );
  }

  factory Account.empty() {
    return const Account(
      email: '',
      fullname: '',
      authTypes: [],
      bannedAt: null,
      createdAt: null,
    );
  }

  bool get isStarter => role == Role.starter;

  bool get isModerator => role == Role.moderator;

  bool get isAdmin => role == Role.admin;

  bool get isAnonymous => email.isEmpty && authTypes.contains(AuthType.anonymous);

  bool get canEditEmail => authTypes.contains(AuthType.email);
}

class AuthAccount {
  final User? user;
  final Account? account;

  const AuthAccount([this.user, this.account]);

  bool get hasUser => user != null;

  bool get hasAccount => hasUser && account != null;
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

class GridSizeConverter implements JsonConverter<GridSize, String> {
  const GridSizeConverter();

  @override
  GridSize fromJson(String val) {
    try {
      return GridSize.values.byName(val);
    } catch (err, _) {
      return defaultGridSize;
    }
  }

  @override
  String toJson(GridSize val) => val.name;
}

class TextSizeConverter implements JsonConverter<TextSize, String> {
  const TextSizeConverter();

  @override
  TextSize fromJson(String val) {
    try {
      return TextSize.values.byName(val);
    } catch (err, _) {
      return defaultTextSize;
    }
  }

  @override
  String toJson(TextSize val) => val.name;
}

class AuthTypeConverter implements JsonConverter<List<AuthType>, List> {
  const AuthTypeConverter();

  @override
  List<AuthType> fromJson(List val) {
    return val.map((item) => AuthType.values.byName(item as String)).toList();
  }

  @override
  List toJson(List<AuthType> val) => val.map((item) => item.name).toList();
}
