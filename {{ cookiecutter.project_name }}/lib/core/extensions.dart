import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slugify/slugify.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'utils.dart';
import 'globals.dart';
import 'config/config.dart';

extension StringExtension on String {
  /// Capitalize the first character
  String capitalize() {
    if (length == 0) return this;
    if (length == 1) return this[0].toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Limit the String to a certain number of characters
  String truncate([int end = 10, String append = '...']) {
    if (length > end) return '${substring(0, end)}$append';
    return this;
  }

  /// Slugify the string
  String toSlug() {
    return slugify(this);
  }

  Map<String, dynamic> decodeJson() {
    if (isEmpty) return {};
    try {
      Map<String, dynamic> mm = json.decode(this);
      return mm;
    } catch (err, _) {
      return {};
    }
  }

  Timestamp? decodeToTimestamp() {
    DateTime? dt = DateTime.tryParse(this);
    if (dt == null) return null;
    Timestamp ts = Timestamp.fromDate(dt);
    return ts;
  }

  DateTime? decodeToDateTime() {
    DateTime? dt = DateTime.tryParse(this);
    return dt;
  }
}

extension ListExtension on List {
  /// Check if 2 lists have the same elements regardless of their order.
  /// Use [sameOrder] if you want to check for ordering as well.
  bool sameWith(List list_, [sameOrder = false]) {
    if (!sameOrder) {
      sort();
      list_.sort();
    }

    if (listEquals(this, list_)) return true;
    return false;
  }
}

extension MapExtension on Map {
  Map<Symbol, dynamic> symbolizeKeys() {
    return map((k, v) => MapEntry(Symbol(k), v));
  }
}

extension DateTimeExtension on DateTime {
  DateTime dateOnly() => DateTime(year, month, day);

  String formatStr(String format) => DateFormat(format).format(this);
}

extension PrefExt on SharedPreferences {
  /// Get the value of [setting] or use [val] if it doesn't exist.
  /// If [val] is used then it is saved as the new value of [setting].
  Future<T> getAndSave<T>(Setting setting, T val) async {
    String key = setting.name;
    if (containsKey(key)) return get(key)! as T;

    switch (T) {
      case const (String):
        await setString(key, val as String);
        return val;
      case const (int):
        await setInt(key, val as int);
        return val;
      case const (double):
        await setDouble(key, val as double);
        return val;
      case const (bool):
        await setBool(key, val as bool);
        return val;
      case const (List<String>):
        await setStringList(key, val as List<String>);
        return val;
      default:
        throw Exception('Wrong data type to save to prefs');
    }
  }
}
