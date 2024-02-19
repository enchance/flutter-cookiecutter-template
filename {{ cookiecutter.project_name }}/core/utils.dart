import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slugify/slugify.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

/*
* Extract tags from a string and return them as an array.
* Tags are identified as any text starting with #
* Also supports custom / regex if needed
* e.g. #foo /foo
* */

Map<String, dynamic> extractTags(String str) {
  RegExp tagRegex = RegExp(r"\B#[\w-]+");     // #foo
  RegExp otherRegex = RegExp(r"\B/[\w-]+");   // /foo
  List<String> tags = [];
  List<String> others = [];

  tagRegex.allMatches(str).forEach((match){
    // tags.add(match.group(0)!.substring(1));
    tags.add(match.group(0)!);
  });

  otherRegex.allMatches(str).forEach((match){
    // others.add(match.group(0)!.substring(1));
    others.add(match.group(0)!);
  });

  var l = str.split(' ');
  int index = l.lastIndexWhere((element) => !element.contains('#') && !element.contains('/'));
  l.removeRange(index + 1, l.length);
  String text = l.join(' ');

  return {
    'text': text.trim(),
    'tags': tags,
    'others': others,
  };
}

// List reorderByPattern(Map<String, dynamic> datamap, List<String> pattern) {
//   List ll = [];
//   for(String str in pattern) {
//     if(!datamap.containsKey(str)) continue;
//     ll.add(datamap[str]);
//   }
//
//   return ll;
// }

/// <T> must have a toMap method.
// List<T> reorderByPattern<T, F>(List<T> datalist, String attr, List<F> pattern) {
//   Map<F, T> datamap = { for (var e in datalist) e.toMap()[attr] : e };
//
//   List<T> ll = [];
//   for(F item in pattern) {
//     if(!datamap.containsKey(item)) continue;
//     ll.add(datamap[item] as T);
//   }
//
//   return ll;
// }

extension StringExtension on String {
  /// Capitalize the first character
  String capitalize() {
    if(length == 0) return this;
    if(length == 1) return this[0].toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Limit the String to a certain number of characters
  String truncate([int end=10, String append='...']) {
    if(length > end) return '${substring(0, end)}$append';
    return this;
  }

  /// Slugify the string
  String toSlug() {
    return slugify(this);
  }
}

extension ListExtension on List {
  /// Check if 2 lists have the same elements regardless of their order.
  /// Use [sameOrder] if you want to check for ordering as well.
  bool sameWith(List list_, [sameOrder=false]) {
    if(!sameOrder) {
      sort();
      list_.sort();
    }

    if(listEquals(this, list_)) return true;
    return false;
  }
}

// extension on MaterialColor {
//   Color tint(double factor) => Color.fromRGBO(
//     tintValue(this.red, factor),
//     tintValue(this.green, factor),
//     tintValue(this.blue, factor),
//   1);
//
//   Color shade(double factor) => Color.fromRGBO(
//     shadeValue(this.red, factor),
//     shadeValue(this.green, factor),
//     shadeValue(this.blue, factor),
//   1);
// }

// extension on Color {
//   Color tint(double factor) => Color.fromRGBO(
//     tintValue(this.red, factor),
//     tintValue(this.green, factor),
//     tintValue(this.blue, factor),
//   1);
//
//   Color shade(double factor) => Color.fromRGBO(
//     shadeValue(this.red, factor),
//     shadeValue(this.green, factor),
//     shadeValue(this.blue, factor),
//   1);
// }


int randomint(int min, int max) {
  return min + Random().nextInt(max - min);
}

/// Get the file size of the file to be uploaded
///
///   XFile? upload = await picker.pickImage(source: ImageSource.camera);
///   if(upload != null) print(getFileSizeString(bytes: await upload!.length());
String getFileSizeString({required int bytes, int decimals = 0}) {
  if (bytes <= 0) return "0 Bytes";
  const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
  var i = (log(bytes) / log(1024)).floor();

  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}

/// Check if a date is today.
bool isToday(DateTime dt, [DateTime? basedate]) {
  basedate = basedate ?? DateTime.now();
  return basedate.difference(dt).inDays == 0;
}

/// Check if a date is tomorrow.
bool isTomorrow(DateTime dt, [DateTime? basedate]) {
  basedate = basedate ?? DateTime.now();
  return basedate.difference(dt).inDays == 1;
}

/*
* Generate a random string of set length.
* */
String generateRandomStr(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) {
      const chars = '0123456789abcdefghijklmnopqrstuvwxyz';
      Random rnd = Random();
      return chars.codeUnitAt(rnd.nextInt(chars.length));
}));

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor), tintValue(color.green, factor), tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor), shadeValue(color.green, factor), shadeValue(color.blue, factor),
    1);

Color saturateColor(Color color, double val) {
  return HSLColor.fromColor(color).withSaturation(val).toColor();
}

Color alphaColor(Color color, double val) {
  return HSLColor.fromColor(color).withAlpha(val).toColor();
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

/// Format a datTime object to String
String datetimeToString(DateTime? dt, {bool withTime=false, String format='MMM dd, yyyy'}) {
  if(dt == null) return '';

  DateFormat dayformat = DateFormat(format);
  if(withTime) dayformat = dayformat.add_jm();
  // TimeOfDayFormat timeformat = TimeOfDayFormat.a_space_h_colon_mm;

  return dayformat.format(dt);
}

/// Round the results of a timer with [decimal] places.
String roundoff(Stopwatch stopwatch_, [int decimals=3]) {
  return (stopwatch_.elapsedMilliseconds / 1000).toStringAsFixed(decimals);
}

/// Encode a DateTime to str which you can parse with DateTime.parse().
dynamic encodeFunc(dynamic item) {
  if(item is DateTime) return item.toIso8601String();
  return item;
}

extension PrefExt on SharedPreferences {

  /// Checks if a key key exists. If it doesn't then it creates it using [val].
  /// If it does then return the prefs value and disregard [val].
  Future<T> getAndSave<T>(String key, T val) async {
    if(containsKey(key)) val = get(key)! as T;

    switch(T) {
      case const (String):
        if(!containsKey(key)) {
          print('SETTING: ${T}');
          await setString(key, val as String);
        }
        break;
      case const (int):
        if(!containsKey(key)) {
          print('SETTING: ${T}');
          await setInt(key, val as int);
        }
        break;
      case const (double):
        if(!containsKey(key)) {
          print('SETTING: ${T}');
          await setDouble(key, val as double);
        }
        break;
      case const (bool):
        if(!containsKey(key)) {
          print('SETTING: ${T}');
          await setBool(key, val as bool);
        }
        break;
      case const (List<String>):
        if(!containsKey(key)) {
          print('SETTING: ${T}');
          await setStringList(key, val as List<String>);
        }
      default:
        throw Exception('Wrong data type to save to prefs');
    }
    return val;
  }
}
