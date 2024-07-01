import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    final String? id,
    @NullConverter() required final String email,
    required final String fullname,
    required final String phone,
    @Default('') final String avatar,
    @Default('') final String display,
    @Default('') @NullConverter() final String username,
    @Default('') final String gender,
    @Default('') final String status,
    DateTime? birthday,
    @AuthTypeConverter() required final Set<AuthType> providers,
    @RolesConverter() required final Set<Role> roles,
    @JsonKey(name: 'provider_id') @Default('') final String providerId,
    @JsonKey(name: 'cover_profile') @Default('') final String coverProfile,
    @JsonKey(name: 'banned_at') DateTime? bannedAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) => _$AccountFromJson(json);

  factory Account.create({
    required AuthType provider,
    String? id,
    String? email,
    String? fullname,
    String? phone,
    String? display,
    String? avatar,
    Role role = defaultRole,
  }) {
    final (firstname, _) = splitName(fullname ?? '');
    return Account(
      id: id,
      email: email ?? '',
      fullname: fullname ?? firstname,
      phone: phone ?? '',
      avatar: avatar ?? '',
      display: display ?? firstname,
      providers: {provider},
      roles: {role},
    );
  }

  factory Account.empty() {
    return const Account(
      email: '',
      fullname: '',
      phone: '',
      providers: {},
      roles: {Role.starter},
    );
  }

  bool get isStarter => roles.contains(Role.starter);

  bool get isModerator => roles.contains(Role.moderator);

  bool get isAdmin => roles.contains(Role.admin);

  bool get isAnonymous => email.isEmpty && providers.contains(AuthType.anonymous);

  bool get canEditEmail => providers.contains(AuthType.email);

  bool get canLinkAccount => !providers.contains(AuthType.google);

  bool get isEmpty => providers.isEmpty && email.isEmpty;
}

// class AuthAccount {
//   final Session? session;
//   final Account? account;
//
//   const AuthAccount([this.session, this.account]);
//
//   bool get hasSession => session != null;
//
//   bool get hasAccount => hasSession && account != null;
// }

class NullConverter implements JsonConverter<String, String?> {
  const NullConverter();

  @override
  String fromJson(String? val) {
    if (val == null) return '';
    return val;
  }

  @override
  String? toJson(String val) {
    if (val.isEmpty) return null;
    return val;
  }
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp ts) => ts.toDate();

  @override
  Timestamp toJson(DateTime dt) => Timestamp.fromDate(dt);
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

class AuthTypeConverter implements JsonConverter<Set<AuthType>, List> {
  const AuthTypeConverter();

  @override
  Set<AuthType> fromJson(List val) {
    return val.map((item) => AuthType.values.byName(item as String)).toSet();
  }

  @override
  List toJson(Set<AuthType> val) => val.map((item) => item.name).toList();
}

class RolesConverter implements JsonConverter<Set<Role>, List> {
  const RolesConverter();

  @override
  Set<Role> fromJson(List val) {
    return val.map((item) => Role.values.byName(item as String)).toSet();
  }

  @override
  List toJson(Set<Role> val) => val.map((item) => item.name).toList();
}
