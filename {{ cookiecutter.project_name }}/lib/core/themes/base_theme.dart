import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

import '../core.dart';

/// https://pub.dev/packages/settings_ui
SettingsThemeData getSettingsTheme(BuildContext context) {
  return SettingsThemeData(
    settingsListBackground: Theme.of(context).colorScheme.background,
    settingsTileTextColor: Theme.of(context).colorScheme.onBackground,
    // leadingIconsColor: Colors.grey,
    leadingIconsColor: Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade600
        : Colors.grey.shade300,
  );
}

/*
*  ____                   _____ _
* | __ )  __ _ ___  ___  |_   _| |__   ___ _ __ ___   ___
* |  _ \ / _` / __|/ _ \   | | | '_ \ / _ \ '_ ` _ \ / _ \
* | |_) | (_| \__ \  __/   | | | | | |  __/ | | | | |  __/
* |____/ \__,_|___/\___|   |_| |_| |_|\___|_| |_| |_|\___|
* */
class BaseTheme {
  Color background;
  Color onBackground;
  Color primary;
  Color onPrimary;
  Color secondary;
  Color onSecondary;
  Color tertiary;
  Color onTertiary;
  Color surface;
  Color onSurface;

  TextStyle bodyStyle;
  TextStyle titleStyle;
  TextStyle displayStyle;
  double radius = 5;
  double bodySmallFontSize = 16;
  double bodyMediumFontSize = 18;
  double bodyLargeFontSize = 20;
  double titleSmallFontSize = 22;
  double titleMediumFontSize = 24;
  double titleLargeFontSize = 28;
  double displaySmallFontSize = 22;
  double displayMediumFontSize = 24;
  double displayLargeFontSize = 28;

  BaseTheme(
      {required this.background,
      required this.onBackground,
      this.primary = const Color(0xFF57cc99),
      this.onPrimary = Colors.black87,
      this.secondary = const Color(0xFFffb400),
      this.onSecondary = Colors.black87,
      this.tertiary = const Color(0xFFe8eddf),
      this.onTertiary = Colors.black54,
      required this.surface,
      required this.onSurface})
      : bodyStyle = TextStyle(color: onBackground),
        titleStyle = TextStyle(color: onBackground, fontWeight: FontWeight.bold),
        displayStyle = TextStyle(color: onBackground);

  ThemeData get theme => ThemeData(useMaterial3: true).copyWith(
        // TODO: Don't use Colorgen for the base theme
        scaffoldBackgroundColor: background,
        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            bodySmall: bodyStyle.copyWith(fontSize: bodySmallFontSize),
            bodyMedium: bodyStyle.copyWith(fontSize: bodyMediumFontSize),
            bodyLarge: bodyStyle.copyWith(fontSize: bodyLargeFontSize),
            titleSmall: titleStyle.copyWith(fontSize: titleSmallFontSize),
            titleMedium: titleStyle.copyWith(fontSize: titleMediumFontSize),
            titleLarge: titleStyle.copyWith(fontSize: titleLargeFontSize),
            displaySmall: displayStyle.copyWith(fontSize: displaySmallFontSize),
            displayMedium: displayStyle.copyWith(fontSize: displayMediumFontSize),
            displayLarge: displayStyle.copyWith(fontSize: displayLargeFontSize),
          ),
        ),
        colorScheme: ColorScheme.light(
          background: background,
          onBackground: onBackground,
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          tertiary: tertiary,
          onTertiary: onTertiary,
          surface: surface,
          onSurface: onSurface,
          errorContainer: tintColor(Colors.pink, 0.8),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          foregroundColor: onBackground,
          titleTextStyle: bodyStyle.copyWith(fontSize: 24, color: Colors.black87),
          iconTheme: IconThemeData(color: onBackground),
          shadowColor: Colors.black,
          // https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll/72773421#answer-72413437
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 50)),
            textStyle: const MaterialStatePropertyAll<TextStyle>(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 12)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
            surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled) ? tintColor(primary, 0.4) : primary;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled) ? shadeColor(primary, 0.1) : onPrimary;
            }),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 50)),
            textStyle: const MaterialStatePropertyAll<TextStyle>(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 12)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
            side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.grey)),
            // surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
            // backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            //   return states.contains(MaterialState.disabled)
            //       ? tintColor(primary, 0.4)
            //       : primary;
            // }),
            foregroundColor: const MaterialStatePropertyAll<Color>(Colors.grey),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 0),
          hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          labelStyle: const TextStyle(color: Colors.black54),
          floatingLabelStyle: TextStyle(
            color: onBackground,
            fontWeight: FontWeight.bold,
            fontSize: bodySmallFontSize,
          ),
          enabledBorder: const UnderlineInputBorder(),
        ),
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: onBackground),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: onBackground,
          textColor: onBackground,
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return background;
            if (states.contains(MaterialState.selected)) return primary;
            return const Color(0xFFc4c4c4);
          }),
          trackOutlineColor: MaterialStatePropertyAll<Color>(Colors.grey.shade600),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: primary,
          // overlayColor: const MaterialStatePropertyAll<Color>(Colors.red),
          // indicatorColor: onPrimary,
          indicatorColor: Colors.white,
          labelTextStyle:
              MaterialStateProperty.resolveWith<TextStyle?>((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(
                color: onPrimary,
                fontSize: bodySmallFontSize,
                fontWeight: FontWeight.bold,
              );
            }
            // return TextStyle(color: onPrimary.withOpacity(0.4), fontSize: bodySmallFontSize);
            return TextStyle(
              color: onPrimary.withOpacity(0.4),
              fontSize: bodySmallFontSize,
              fontWeight: FontWeight.bold,
            );
          }),
          iconTheme: MaterialStatePropertyAll<IconThemeData>(
            IconThemeData(
              color: onPrimary,
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(space: 0),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
}