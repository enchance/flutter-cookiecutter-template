import 'package:responsive_framework/responsive_framework.dart';

import '../core.dart';

const List<Breakpoint> responsiveBreakpoints = [
  Breakpoint(start: 0, end: 500, name: MOBILE),
  Breakpoint(start: 501, end: 1100, name: TABLET),
  Breakpoint(start: 1101, end: 1920, name: DESKTOP),
  Breakpoint(start: 1921, end: double.infinity, name: '4K'),
];

const country = '{{ cookiecutter.country }}';
const defaultRole = Role.common;

// Settings defaults.
// Once the app has run data will be taken from SharedPreferences and not here.
const bool darkMode = false;
const FontSizes fontSize = FontSizes.md;
const bool lockPortrait = false;
const bool allowNotifications = true;

// Others
const String dateFormat = 'MMMM d, y';
