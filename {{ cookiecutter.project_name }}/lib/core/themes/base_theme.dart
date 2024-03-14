import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

import '../core.dart';

// /// https://pub.dev/packages/settings_ui
// SettingsThemeData getSettingsTheme(BuildContext context) {
//   return SettingsThemeData(
//     settingsListBackground: Theme.of(context).colorScheme.background,
//     settingsTileTextColor: Theme.of(context).colorScheme.onBackground,
//     // leadingIconsColor: Colors.grey,
//     leadingIconsColor: Theme.of(context).brightness == Brightness.light
//         ? Colors.grey.shade600
//         : Colors.grey.shade300,
//   );
// }

/*
*  ____                   _____ _
* | __ )  __ _ ___  ___  |_   _| |__   ___ _ __ ___   ___
* |  _ \ / _` / __|/ _ \   | | | '_ \ / _ \ '_ ` _ \ / _ \
* | |_) | (_| \__ \  __/   | | | | | |  __/ | | | | |  __/
* |____/ \__,_|___/\___|   |_| |_| |_|\___|_| |_| |_|\___|
* */
class BaseTheme {
  Brightness brightness;
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
  double titleSmallFontSize = 28;
  double titleMediumFontSize = 34;
  double titleLargeFontSize = 44;
  double displaySmallFontSize = 22;
  double displayMediumFontSize = 24;
  double displayLargeFontSize = 28;

  BaseTheme(
      {required this.background,
      required this.onBackground,
      required this.brightness,
      this.primary = Colors.blue,
      this.onPrimary = Colors.black87,
      this.secondary = Colors.green,
      this.onSecondary = Colors.black87,
      this.tertiary = Colors.teal,
      this.onTertiary = Colors.black54,
      required this.surface,
      required this.onSurface})
      : bodyStyle = TextStyle(color: onBackground, height: 1.2),
        titleStyle = TextStyle(color: onBackground, fontWeight: FontWeight.bold, height: 1),
        displayStyle = TextStyle(color: onBackground, height: 1);

  bool get isDark => brightness == Brightness.dark;

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
        colorScheme: ColorScheme(
          brightness: brightness,
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
          errorContainer: Colors.pink.shade50,
          error: Colors.pink.shade400,
          onError: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          foregroundColor: onBackground,
          titleTextStyle: bodyStyle.copyWith(fontSize: 24, color: onBackground),
          iconTheme: IconThemeData(color: onBackground),
          shadowColor: Colors.black,
          // https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll/72773421#answer-72413437
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll<Color>(Colors.orangeAccent),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (isDark) {
                return states.contains(MaterialState.disabled)
                    ? tintColor(background, 0.1)
                    : primary;
              }
              return states.contains(MaterialState.disabled) ? Colors.grey.shade300 : primary;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled) ? Colors.grey : onPrimary;
            }),
            minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 45)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (isDark) {
                return states.contains(MaterialState.disabled)
                    ? tintColor(background, 0.1)
                    : Colors.transparent;
              }
              return states.contains(MaterialState.disabled)
                  ? Colors.grey.shade300
                  : Colors.transparent;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? Colors.grey.shade400
                  : onBackground.withOpacity(0.5);
            }),
            // Size is slightly larger than ElevatedButton
            minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 48)),
            side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
              if (isDark) {
                return states.contains(MaterialState.disabled)
                    ? BorderSide.none
                    : const BorderSide(color: Colors.grey, width: 2);
              }
              return states.contains(MaterialState.disabled)
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade400, width: 2);
            }),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: isDark ? tintColor(background, 0.09) : Colors.grey.shade200,
          contentPadding: const EdgeInsets.only(top: 7, bottom: 2, left: 5, right: 0),
          counterStyle: const TextStyle(color: Colors.grey),
          hintStyle: bodyStyle.copyWith(color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelStyle: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: bodyMediumFontSize,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.pink.shade400),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.pink.shade400),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
        ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(tintColor(primary, 0.3)),
        )),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
        // checkboxTheme: CheckboxThemeData(
        //   side: BorderSide(color: onBackground),
        // ),
        // listTileTheme: ListTileThemeData(
        //   iconColor: onBackground,
        //   textColor: onBackground,
        // ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
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
