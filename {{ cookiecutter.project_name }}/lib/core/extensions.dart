import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slugify/slugify.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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
  String slug() => slugify(this);

  Map<String, dynamic> decodeJson() {
    if (isEmpty) return {};
    try {
      Map<String, dynamic> mm = json.decode(this);
      return mm;
    } catch (err, _) {
      return {};
    }
  }

  Timestamp? toTimestamp() {
    DateTime? dt = DateTime.tryParse(this);
    if (dt == null) return null;
    Timestamp ts = Timestamp.fromDate(dt);
    return ts;
  }

  DateTime? toDateTime() {
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

  Map<String, dynamic> sortByValue() {
    return SplayTreeMap<String, dynamic>.from(this, (k1, k2) => this[k1].compareTo(this[k2]));
  }

  Map<String, dynamic> sortByKey() {
    return SplayTreeMap<String, dynamic>.from(this, (k1, k2) => k1.compareTo(k2));
  }

  Map<String, dynamic> filterByKey(String partialString) {
    String text = partialString.toLowerCase();
    return Map.fromEntries(entries
        .where((entry) => entry.key.toLowerCase().contains(text))
        .map((entry) => MapEntry<String, dynamic>(entry.key, entry.value))
        .toList());
  }

  Map<String, dynamic> filterByValue(String partialString) {
    String text = partialString.toLowerCase();
    return Map.fromEntries(entries
        .where((entry) => entry.value.toLowerCase().contains(text))
        .map((entry) => MapEntry<String, dynamic>(entry.key, entry.value))
        .toList());
  }
}

extension DateTimeExtension on DateTime {
  DateTime dateOnly() => DateTime(year, month, day);

  DateTime minutesOnly() => DateTime(year, month, day, hour, minute);

  DateTime hoursOnly() => DateTime(year, month, day, hour);

  String formatStr(String format) => DateFormat(format).format(this);

  /// Check if a date is today.
  bool isToday(DateTime dt) => difference(dt).inDays == 0;

  /// Check if a date is tomorrow.
  bool isTomorrow(DateTime dt) => difference(dt).inDays == 1;
}
