import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:slugify/slugify.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core.dart';
// import '../scans/scans.dart';

/// Extract tags from a string and return them as an array.
/// Tags are identified as any text starting with #
/// Also supports custom / regex if needed
/// e.g. #foo /foo
Map<String, dynamic> extractTags(String str) {
  RegExp tagRegex = RegExp(r"\B#[\w-]+"); // #foo
  RegExp otherRegex = RegExp(r"\B/[\w-]+"); // /foo
  List<String> tags = [];
  List<String> others = [];

  tagRegex.allMatches(str).forEach((match) {
    // tags.add(match.group(0)!.substring(1));
    tags.add(match.group(0)!);
  });

  otherRegex.allMatches(str).forEach((match) {
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

// extension TimestampExtension on Timestamp {
//   String encodeTimestamp() {
//     DateTime dt = toDate();
//     String str = dt.toIso8601String();
//     return str;
//   }
// }

// int randomint(int min, int max) {
//   return min + Random().nextInt(max - min);
// }

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

/// Generate a random string of set length.
String generateRandomStr(int length) => String.fromCharCodes(Iterable.generate(length, (_) {
      const chars = '0123456789abcdefghijklmnopqrstuvwxyz';
      Random rnd = Random();
      return chars.codeUnitAt(rnd.nextInt(chars.length));
    }));

int tintValue(int value, double factor) {
  return max(0, min((value + ((255 - value) * factor)).round(), 255));
}

int shadeValue(int value, double factor) => max(0, min(value - (value * factor).round(), 255));

/// Lighten a color. [factor] is relative to 0 where 0 is no change, I think.
Color tintColor(Color color, double factor) {
  return Color.fromRGBO(tintValue(color.red, factor), tintValue(color.green, factor),
      tintValue(color.blue, factor), 1);
}

/// Darken a color. [factor] is relative to 0 where 0 is no change, I think.
Color shadeColor(Color color, double factor) {
  return Color.fromRGBO(shadeValue(color.red, factor), shadeValue(color.green, factor),
      shadeValue(color.blue, factor), 1);
}

Color saturateColor(Color color, double val) {
  return HSLColor.fromColor(color).withSaturation(val).toColor();
}

Color alphaColor(Color color, double val) {
  return HSLColor.fromColor(color).withAlpha(val).toColor();
}

/// Format a datTime object to String
String datetimeToString(DateTime? dt, {bool withTime = false, String format = 'MMM dd, yyyy'}) {
  if (dt == null) return '';

  DateFormat dayformat = DateFormat(format);
  if (withTime) dayformat = dayformat.add_jm();
  // TimeOfDayFormat timeformat = TimeOfDayFormat.a_space_h_colon_mm;

  return dayformat.format(dt);
}

/// Round the results of a timer with [decimal] places.
String roundoff(Stopwatch stopwatch_, [int decimals = 3]) {
  return (stopwatch_.elapsedMilliseconds / 1000).toStringAsFixed(decimals);
}

/// Encode a DateTime to str which you can parse with DateTime.parse().
dynamic encodeFunc(dynamic item) {
  if (item is DateTime) return item.toIso8601String();
  return item;
}

extension PrefExt on SharedPreferences {
  /// Checks if a key key exists. If it doesn't then it creates it using [val].
  /// If it does then return the prefs value and disregard [val].
  Future<T> getAndSave<T>(String key, T val) async {
    if (containsKey(key)) val = get(key)! as T;

    switch (T) {
      case const (String):
        if (!containsKey(key)) {
          // print('SETTING: ${T}');
          await setString(key, val as String);
        }
        break;
      case const (int):
        if (!containsKey(key)) {
          // print('SETTING: ${T}');
          await setInt(key, val as int);
        }
        break;
      case const (double):
        if (!containsKey(key)) {
          // print('SETTING: ${T}');
          await setDouble(key, val as double);
        }
        break;
      case const (bool):
        if (!containsKey(key)) {
          // print('SETTING: ${T}');
          await setBool(key, val as bool);
        }
        break;
      case const (List<String>):
        if (!containsKey(key)) {
          // print('SETTING: ${T}');
          await setStringList(key, val as List<String>);
        }
      default:
        throw Exception('Wrong data type to save to prefs');
    }
    return val;
  }
}

T setResponsiveValue<T>(BuildContext context,
    {T? phone, required T mobile, T? tablet, T? desktop, T? largerThanDesktop}) {
  // if (kDebugMode) {
  //   if (ResponsiveBreakpoints.of(context).isDesktop) logger.d('isDesktop');
  //   if (ResponsiveBreakpoints.of(context).isTablet) logger.d('isTablet');
  //   if (ResponsiveBreakpoints.of(context).isMobile) logger.d('isMobile');
  //   if (ResponsiveBreakpoints.of(context).isPhone) logger.d('isPhone');
  //   if (ResponsiveBreakpoints.of(context).largerThan(DESKTOP)) logger.d('is4K');
  // }

  final breakpoints = ResponsiveBreakpoints.of(context);
  if (breakpoints.largerThan(DESKTOP)) return largerThanDesktop ?? desktop ?? tablet ?? mobile;
  if (breakpoints.equals(DESKTOP)) return desktop ?? tablet ?? mobile;
  if (breakpoints.equals(TABLET)) return tablet ?? mobile;
  if (breakpoints.equals(MOBILE)) return mobile;
  return phone ?? mobile;
}

String prefKey(String str) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return str;
  return '$str-${user.uid}';
}

/// Split a name into their respective first and last names
/// Accomodates names in the farmats of:
///   - John Doe
///   - Doe, John
///   - Jahn Jeff Doe
///
///   - Jahn Jeff Doe III
///   - Jahn Jeff San Doe III
///   - Jahn Jeff Delos Doe III PhD
///   - Jahn Jeff J. delos Doe III PhD  (middle initial period is optional)
///   - Mr. Jahn Jeff J. Delos Doe III PhD
///
// (String, String) splitName(String fullName) {
//   String firstName = '';
//   String lastName = '';
//
//   List<String> namePrefixes = [

//   ];
//
//   List<String> lastNamePrefixes = [

//   ];
//
//   // Trim input and return immediately if the name has only one word
//   fullName = fullName.trim();
//   if (fullName.split(RegExp(r'\s+')).length == 1) {
//     return (fullName, '');
//   }
//
//   // Split by comma with optional spaces
//   List<String> nameParts = fullName.split(RegExp(r'\s*,\s*'));
//   if (nameParts.length == 1) nameParts = fullName.split(RegExp(r'\s+'));
//
//   // Name prefixes
//   while (nameParts.isNotEmpty && namePrefixes.contains(nameParts.first.replaceAll('.', ''))) {
//     firstName += '${nameParts.removeAt(0)} ';
//   }
//
//   // Middle initial handling: move to first name
//   if (nameParts.isNotEmpty && (nameParts.last.length == 1 || nameParts.last.endsWith('.'))) {
//     firstName += '${nameParts.removeLast()} ';
//   }
//
//   // Last name with dashes handling
//   if (nameParts.isNotEmpty && nameParts.last.contains('-')) {
//     lastName = nameParts.removeLast();
//   } else {
//     // Last name prefixes and remaining parts as last name
//     if (nameParts.isNotEmpty) {
//       lastName = nameParts.removeLast();
//       while (nameParts.isNotEmpty && lastNamePrefixes.contains(nameParts.last.toLowerCase())) {
//         lastName = '${nameParts.removeLast()} $lastName';
//       }
//     }
//   }
//
//   // Remaining parts are the first name
//   firstName += nameParts.join(' ');
//
//   return (firstName.trim(), lastName.trim());
// }

(String, String) splitName(String fullName) {
  String firstName = '';
  String lastName = '';
  String suffixRegex = r'\b(Phd|MD|Esq|Jr|Sr|I{1,3}|IV|V|VI|VII|VIII|IX|X)\b';
  String prefixRegex =
      r'\b(mr|mrs\.?|ms\.?|miss|sir|don|dr\.?|prof\.?|mx|rev\.?|hon\.?|dame|lady|lord|sr\.?|sra\.?|srta\.?|doña|m|mme\.?|mlle\.?|herr|frau|sig\.?|sig.ra|sig.na|dott|dhr\.?|mevr\.?|sheikh|sheikha|sayyid|sayyida|gen\.?|sgt\.?|col\.?|fr\.?)\b';
  List<String> lastNamePrefixes = [
    'de',
    'del',
    'de la',
    'de los',
    'delos',
    'la',
    'las',
    'los',
    'san',
    'don',
    'dos',
    'da',
    'das',
    'do',
    'du',
    'de l’',
    'des',
    'le',
    'les',
    'van',
    'van de',
    'van der',
    'van den',
    'ter',
    'ten',
    'te',
    'di',
    'della',
    'dello',
    'von',
    'zu',
    'zum',
    'zur',
    'al-',
    'bin',
    'ibn',
  ];

  // Handle emails
  if(fullName.contains('@')) fullName = fullName.split('@').first.replaceAll('.', ' ');

  // Handle names with commas
  if (fullName.contains(',')) {
    List<String> parts = fullName.split(',');
    lastName = parts[0].trim();
    firstName = parts[1].trim();

    if (!RegExp(suffixRegex, caseSensitive: false).hasMatch(firstName)) {
      return (firstName, lastName);
    }
  }

  // Split the name into parts
  List<String> nameParts = fullName.trim().split(' ');
  if (nameParts.length == 1) return (nameParts.first.trim(), '');

  // Find the index of the last name
  int? lastNameIndex;
  for (int i = 0; i < nameParts.length; i++) {
    String part = nameParts[i];
    if (part.length == 1 || (part.length == 2 && part.endsWith('.'))) {
      lastNameIndex = i + 1;
      break;
    } else if (lastNamePrefixes.any((prefix) => part.toLowerCase().startsWith(prefix))) {
      lastNameIndex = i;
      break;
    } else if (RegExp(suffixRegex).hasMatch(part)) {
      lastNameIndex = i - 1;
      break;
    }
  }
  lastNameIndex = lastNameIndex ?? nameParts.length - 1;
  firstName = nameParts.sublist(0, lastNameIndex).join(' ');
  lastName = nameParts.sublist(lastNameIndex).join(' ');
  return (firstName, lastName);
}

/// Try to parse the display name from a name or email.
String parseDisplayName(String nameOrEmail) {
  String prefixRegex =
      r'\b(mr|mrs\.?|ms\.?|miss|sir|don|dr\.?|prof\.?|mx|rev\.?|hon\.?|dame|lady|lord|sr\.?|sra\.?|srta\.?|doña|m|mme\.?|mlle\.?|herr|frau|sig\.?|sig.ra|sig.na|dott|dhr\.?|mevr\.?|sheikh|sheikha|sayyid|sayyida|gen\.?|sgt\.?|col\.?|fr\.?)\b';
  String displayName = nameOrEmail;

  // Check if email
  final emailSplit = nameOrEmail.split('@');
  if (emailSplit.length == 2) {
    final tmp = emailSplit.first.split('.');
    if (tmp.length == 1) return emailSplit.first;
    return tmp.first;
  }

  List<String> nameParts = nameOrEmail.trim().split(' ');
  if (nameParts.length == 1) return nameParts.first.trim();

  for (int i = 0; i < nameParts.length; i++) {
    if (RegExp(prefixRegex, caseSensitive: false).hasMatch(nameParts[i])) continue;
    if (i == 0) return nameParts.first.trim();
    if (i == nameParts.length - 1) break;
    return nameParts.sublist(0, i + 1).join(' ');
  }
  return displayName;
}
