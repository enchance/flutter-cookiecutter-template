import 'package:flutter/material.dart';

import '../core.dart';
import 'base_theme.dart';

class IndexTheme {
  static final BaseTheme _lightTheme = BaseTheme(
    brightness: Brightness.light,
    primary: const Color(0xFF9FCD1B),
    secondary: const Color(0xFFffb400),
    tertiary: const Color(0xFFe8eddf),
    surface: const Color(0xFFeeeeee),
    onSurface: Colors.black87,
    // surface: Colors.grey.shade800,
    // onSurface: Colors.white,
  );
  static final BaseTheme _darkTheme = BaseTheme(
    brightness: Brightness.dark,
    primary: const Color(0xFFA7D522),
    secondary: const Color(0xFFffb400),
    tertiary: const Color(0xFFe8eddf),
    surface: Colors.grey.shade800,
    onSurface: Colors.white,
    // surface: Colors.grey.shade800,
    // onSurface: Colors.white,
  );

  static ThemeData get lt => _lightTheme.theme;

  static ThemeData get dt => _darkTheme.theme;

  static ColorScheme get ltcolor => lt.colorScheme;

  static ColorScheme get dtcolor => dt.colorScheme;

  IndexTheme._();

  /*
  *  ___           _             _     _       _     _
  * |_ _|_ __   __| | _____  __ | |   (_) __ _| |__ | |_
  *  | || '_ \ / _` |/ _ \ \/ / | |   | |/ _` | '_ \| __|
  *  | || | | | (_| |  __/>  <  | |___| | (_| | | | | |_
  * |___|_| |_|\__,_|\___/_/\_\ |_____|_|\__, |_| |_|\__|
  *                                      |___/
  * Standard
  * */
  static ThemeData light = lt.copyWith(
    appBarTheme: lt.appBarTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey.shade700,
    ),
  );

  /*
  *  ___           _             ____             _
  * |_ _|_ __   __| | _____  __ |  _ \  __ _ _ __| | __
  *  | || '_ \ / _` |/ _ \ \/ / | | | |/ _` | '__| |/ /
  *  | || | | | (_| |  __/>  <  | |_| | (_| | |  |   <
  * |___|_| |_|\__,_|\___/_/\_\ |____/ \__,_|_|  |_|\_\
  *
  * */
  static ThemeData dark = dt.copyWith(
    appBarTheme: dt.appBarTheme.copyWith(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white70,
    ),
    inputDecorationTheme: dt.inputDecorationTheme.copyWith(
      errorStyle: TextStyle(color: Colors.pink.shade200),
    ),
  );
}
