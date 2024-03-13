import 'package:flutter/material.dart';

import '../core.dart';
import 'base_theme.dart';

class IndexTheme {
  static final BaseTheme _lightTheme = BaseTheme(
    background: Colors.grey.shade100,
    onBackground: Colors.black87,
    primary: const Color(0xFF62D2A5),
    secondary: const Color(0xFFffb400),
    tertiary: const Color(0xFFe8eddf),
    surface: Colors.grey.shade800,
    onSurface: Colors.white,
  );
  static final BaseTheme _darkTheme = BaseTheme(
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
  static ThemeData light = lt.copyWith(
    brightness: Brightness.light,
    // inputDecorationTheme: lt.inputDecorationTheme.copyWith(
    //   filled: true,
    //   fillColor: Colors.grey.shade100,
    //   hintStyle: lt.inputDecorationTheme.hintStyle!.copyWith(
    //     color: Colors.grey,
    //   ),
    //   enabledBorder: lt.inputDecorationTheme.enabledBorder!
    //       .copyWith(borderSide: BorderSide(color: Colors.grey.shade500)),
    // ),
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
    brightness: Brightness.dark,
    scaffoldBackgroundColor: dtcolor.background,
    colorScheme: dt.colorScheme.copyWith(
      background: dtcolor.background,
      onBackground: dtcolor.onBackground,
      errorContainer: Colors.pink.shade200.withOpacity(0.9),
    ),
    appBarTheme: dt.appBarTheme.copyWith(
      titleTextStyle: dt.appBarTheme.titleTextStyle!.copyWith(color: dtcolor.onBackground),
    ),
    // inputDecorationTheme: dt.inputDecorationTheme.copyWith(
    //   filled: true,
    //   fillColor: tintColor(dtcolor.background, 0.08),
    //   hintStyle: dt.inputDecorationTheme.hintStyle!.copyWith(color: Colors.grey),
    //   labelStyle: const TextStyle(color: Colors.white60),
    //   enabledBorder: dt.inputDecorationTheme.enabledBorder!
    //       .copyWith(borderSide: BorderSide(color: Colors.grey.shade500)),
    //   errorStyle: TextStyle(color: Colors.pink.shade200),
    //   focusedErrorBorder: UnderlineInputBorder(
    //     borderSide: BorderSide(color: Colors.pink.shade200),
    //   ),
    // ),
  );
}
