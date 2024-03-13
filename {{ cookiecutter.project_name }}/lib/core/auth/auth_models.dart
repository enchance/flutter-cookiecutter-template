import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core.dart';

part 'auth_models.freezed.dart';

part 'auth_models.g.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required final String uid,
    @RoleConverter() required final Role role,
    @Default('') final String email,
    @Default('') final String firstName,
    @Default('') final String lastName,
    @Default('') final String display,
    @Default('') final String avatar,
    @TimestampConverter() final DateTime? createdAt,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) => _$AccountFromJson(json);

  factory Account.create({required String uid, Role role = defaultRole}) {
    return Account(uid: uid, createdAt: DateTime.now(), role: role);
  }
}
