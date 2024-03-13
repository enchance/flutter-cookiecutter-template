import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor), tintValue(color.green, factor), tintValue(color.blue, factor), 1);

int shadeValue(int value, double factor) => max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(shadeValue(color.red, factor),
    shadeValue(color.green, factor), shadeValue(color.blue, factor), 1);

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

T setResponsiveValue<T>(BuildContext context,
    {T? phone, required T mobile, T? tablet, T? desktop, T? largerThanDesktop}) {
  // if (kDebugMode) {
  //   if (ResponsiveBreakpoints.of(context).isDesktop) logger.d('isDesktop');
  //   if (ResponsiveBreakpoints.of(context).isTablet) logger.d('isTablet');
  //   if (ResponsiveBreakpoints.of(context).isMobile) logger.d('isMobile');
  //   if (ResponsiveBreakpoints.of(context).isPhone) logger.d('isPhone');
  //   if (ResponsiveBreakpoints.of(context).largerThan(DESKTOP)) logger.d('is4K');
  // }

  if (ResponsiveBreakpoints.of(context).largerThan(DESKTOP)) {
    return largerThanDesktop ?? desktop ?? tablet ?? mobile;
  } else if (ResponsiveBreakpoints.of(context).equals(DESKTOP)) {
    return desktop ?? tablet ?? mobile;
  } else if (ResponsiveBreakpoints.of(context).equals(TABLET)) {
    return tablet ?? mobile;
  } else if (ResponsiveBreakpoints.of(context).equals(MOBILE)) {
    return mobile;
  }
  return phone ?? mobile;
}

/// Round the results of a timer with [decimal] places.
String roundoff(Stopwatch stopwatch_, [int decimals = 3]) {
  return (stopwatch_.elapsedMilliseconds / 1000).toStringAsFixed(decimals);
}