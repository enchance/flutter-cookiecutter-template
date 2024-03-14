import 'package:flutter/material.dart';

import '../core.dart';
import 'base_theme.dart';

class IndexTheme {
  static final BaseTheme _lightTheme = BaseTheme(
    brightness: Brightness.light,
    primary: const Color(0xFF62D2A5),
    secondary: const Color(0xFFffb400),
    tertiary: const Color(0xFFe8eddf),

    background: Colors.grey.shade100,
    onBackground: Colors.black87,
    surface: Colors.grey.shade800,
    onSurface: Colors.white,
  );
  static final BaseTheme _darkTheme = BaseTheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF62D2A5),
    secondary: const Color(0xFFffb400),
    tertiary: const Color(0xFFe8eddf),

    background: Colors.grey.shade800,
    onBackground: Colors.white,
    surface: Colors.grey.shade50,
    onSurface: Colors.black87,
  );

  static ThemeData get lt => _lightTheme.theme;

  static ThemeData get dt => _darkTheme.theme;

  static ColorScheme get ltcolor => _lightTheme.theme.colorScheme;

  static ColorScheme get dtcolor => _darkTheme.theme.colorScheme;

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
  static ThemeData light = lt.copyWith();

  /*
  *  ___           _             ____             _
  * |_ _|_ __   __| | _____  __ |  _ \  __ _ _ __| | __
  *  | || '_ \ / _` |/ _ \ \/ / | | | |/ _` | '__| |/ /
  *  | || | | | (_| |  __/>  <  | |_| | (_| | |  |   <
  * |___|_| |_|\__,_|\___/_/\_\ |____/ \__,_|_|  |_|\_\
  *
  * */
  static ThemeData dark = dt.copyWith(
    inputDecorationTheme: dt.inputDecorationTheme.copyWith(
      errorStyle: TextStyle(color: Colors.pink.shade200),
    ),
  );
}
