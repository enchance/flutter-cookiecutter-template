import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

import '../core.dart';

/// https://pub.dev/packages/settings_ui
SettingsThemeData generateSettingsUIStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return SettingsThemeData(
    settingsListBackground: Theme.of(context).colorScheme.surface,
    settingsTileTextColor: Theme.of(context).colorScheme.onSurface,
    leadingIconsColor: isDark ? Colors.grey : Colors.grey.shade600,
    tileDescriptionTextColor: isDark ? Colors.grey : Colors.grey.shade600,
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
  Brightness brightness;

  // Color background;
  // Color onBackground;
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
  double bodyLargeFontSize = 22;
  double titleSmallFontSize = 24;
  double titleMediumFontSize = 30;
  double titleLargeFontSize = 40;
  double displaySmallFontSize = 22;
  double displayMediumFontSize = 24;
  double displayLargeFontSize = 28;

  BaseTheme(
      {
      //   required this.background,
      // required this.onBackground,
      required this.brightness,
      this.primary = Colors.blue,
      this.onPrimary = Colors.black87,
      this.secondary = Colors.green,
      this.onSecondary = Colors.black87,
      this.tertiary = Colors.teal,
      this.onTertiary = Colors.black54,
      required this.surface,
      required this.onSurface})
      : bodyStyle = TextStyle(color: onSurface, height: 1.2),
        titleStyle = TextStyle(color: onSurface, fontWeight: FontWeight.bold, height: 1),
        displayStyle = TextStyle(color: onSurface, height: 1);

  bool get isDark => brightness == Brightness.dark;

  ThemeData get theme => ThemeData(useMaterial3: true).copyWith(
        // TODO: Don't use Colorgen for the base theme
        scaffoldBackgroundColor: surface,
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
        primaryColorDark: shadeColor(primary, 0.1),
        primaryColorLight: primary,
        appBarTheme: AppBarTheme(
          backgroundColor: surface,
          foregroundColor: onSurface,
          titleTextStyle: bodyStyle.copyWith(fontSize: 24, color: onSurface),
          iconTheme: IconThemeData(color: onSurface),
          shadowColor: Colors.black,
          // https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll/72773421#answer-72413437
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: const WidgetStatePropertyAll<Color>(Colors.orangeAccent),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (isDark) {
                return states.contains(WidgetState.disabled) ? tintColor(surface, 0.1) : primary;
              }
              return states.contains(WidgetState.disabled) ? Colors.grey.shade300 : primary;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              return states.contains(WidgetState.disabled) ? Colors.grey : onPrimary;
            }),
            minimumSize: const WidgetStatePropertyAll<Size>(Size(200, 45)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (isDark) {
                return states.contains(WidgetState.disabled)
                    ? tintColor(surface, 0.1)
                    : Colors.transparent;
              }
              return states.contains(WidgetState.disabled)
                  ? Colors.grey.shade300
                  : Colors.transparent;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              return states.contains(WidgetState.disabled)
                  ? Colors.grey.shade400
                  : (isDark ? Colors.grey : Colors.grey.shade600);
            }),
            // Size is slightly larger than ElevatedButton
            minimumSize: const WidgetStatePropertyAll<Size>(Size(200, 48)),
            side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
              if (isDark) {
                return states.contains(WidgetState.disabled)
                    ? BorderSide.none
                    : BorderSide(color: primary, width: 2);
              }
              return states.contains(WidgetState.disabled)
                  ? BorderSide.none
                  : BorderSide(color: primary, width: 2);
            }),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            ),
            textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll<Color>(onSurface.withOpacity(0.5)),
            textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
              fontSize: bodyMediumFontSize,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: isDark ? tintColor(surface, 0.09) : Colors.grey.shade300,
          contentPadding: const EdgeInsets.only(top: 7, bottom: 2, left: 5, right: 0),
          counterStyle: const TextStyle(color: Colors.grey),
          hintStyle: bodyStyle.copyWith(fontSize: bodyMediumFontSize, color: Colors.grey),
          labelStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
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
        // menuTheme: MenuThemeData(
        //   style: MenuStyle(
        //     backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
        //     // padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.only(left: 10)),
        //   )
        // ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(fontSize: bodyMediumFontSize),
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: TextStyle(
              color: onSurface,
              // fontWeight: FontWeight.bold,
              // fontSize: bodyLargeFontSize,
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll<Color>(tintColor(primary, 0.3)),
        )),
        // checkboxTheme: CheckboxThemeData(
        //   side: BorderSide(color: onBackground),
        // ),
        listTileTheme: ListTileThemeData(
          iconColor: onSurface,
          textColor: onSurface,
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
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return isDark ? Colors.grey.shade900 : Colors.grey;
            }
            return Colors.black87;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) return surface;
            if (states.contains(WidgetState.selected)) return secondary;
            return const Color(0xFFc4c4c4);
          }),
          trackOutlineColor: WidgetStatePropertyAll<Color>(
            isDark ? Colors.black : Colors.black38,
          ),
          trackOutlineWidth: const WidgetStatePropertyAll<double>(1),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: primary,
          // overlayColor: const MaterialStatePropertyAll<Color>(Colors.red),
          // indicatorColor: onPrimary,
          indicatorColor: Colors.white,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
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
          iconTheme: WidgetStatePropertyAll<IconThemeData>(
            IconThemeData(
              color: onPrimary,
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(space: 0),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        dialogBackgroundColor: surface,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade800,
        ),
      );
}
