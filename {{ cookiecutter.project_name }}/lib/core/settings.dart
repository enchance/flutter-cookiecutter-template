import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core.dart';

part 'settings.freezed.dart';

part 'settings.g.dart';

class Settings {
  Settings({required this.flavor, required this.appName});

  final Flavor flavor;
  final String appName;

  bool get isMain => flavor == Flavor.main;

  bool get isDev => flavor == Flavor.development;

  // *******
  // Routes
  // *******
  // TODO: Cookiecutter
  // authWallAsDefault - true: /authwall, false: / (anonymous sign-in)
  final authWallAsDefault = {{ 'false' if cookiecutter.allow_anonymous else 'true' }};
  // final authWallAsDefault = false; // true: /authwall, false: / (anonymous sign-in)
  final separateSigninView = false;

  // *******
  // Layout
  // *******
  final double padx = 16;
  final double pady = 16;
  final double radius = 5;
  final double maxWidth = 600;
  final double imageMaxHeight = 500;
  final double topGap = 30;
  final double bottomGap = 50;

  // ********
  // Global
  // ********
  // final String languageCode = 'en-us';
  // final List<String> languages = [];

  // ******
  // Forms
  // ******
  final validators = FieldValidators();

  // ******************
  // URLs
  // ******************
  final String hostUrl = '';
  final String androidUrl = '';
  final String rateAndroidUrl = '';
  final String iosUrl = '';
  final String rateIosUrl = '';
  final String instagramUrl = '';
  final String facebookUrl = '';

  // ****************************
  // Colors: (bg, border, text)
  // ****************************
  final (Color, Color, Color) errorBoxColors =
      (Colors.pink.shade50, Colors.pink.shade200, Colors.pink.shade700);
  final (Color, Color, Color) successBoxColors =
      (Colors.lightGreen.shade100, Colors.green.shade300, Colors.green.shade800);
  final (Color, Color, Color) infoBoxColors =
      (const Color(0xFFfff3cd), const Color(0xFFffe69c), const Color(0xFF997404));
  final (Color, Color, Color) greyBoxColors =
      (const Color(0xFFCCCCCC), const Color(0xFF777777), const Color(0xFF555555));
  final (Color, Color) dropdownBackground = (Colors.white, Colors.grey.shade700);

  // ************************************************************
  // DO NOT CHANGE. THESE ARE SET AT THE START OF THE PROJECT.
  // ************************************************************
  final String androidPackageName = '{{ cookiecutter.package_name }}';
  final String iOSBundleId = '';
}

class FieldValidators {
  final text = FormBuilderValidators.compose([
    FormBuilderValidators.maxLength(100),
  ]);
  final textRequired = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.maxLength(100),
  ]);
  final mobile = FormBuilderValidators.compose([
    FormBuilderValidators.match(r'^[\d\-+]+$'),
    FormBuilderValidators.maxLength(15),
  ]);
  final emailRequired = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
    FormBuilderValidators.maxLength(100)
  ]);
  final passwordRequired = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.minLength(6),
    FormBuilderValidators.maxLength(100),
  ]);
}

@Riverpod(keepAlive: true)
Settings settings(SettingsRef ref) => throw UnimplementedError();

/// If you're updating this then also update:
///     - constants.dart:         Set default values
///     - [Startup.initConfig]:   Initialize config data
///     - [AppConfig]:            Modifying config data
///
/// Making this @unfreezed is useless since rebuilds are triggered only on assignment
/// and _not_ when it's mutated.
@freezed
class ConfigMod with _$ConfigMod {
  // If you add to this also update initSettings() + AppSetting enum
  const factory ConfigMod({
    @Default(defaultDarkMode) bool darkMode,
    @Default(defaultFetchCount) int fetchCount,
    @Default(defaultTextSize) TextSize textSize,
    @Default(defaultGridSize) @GridSizeConverter() GridSize gridSize,
  }) = _ConfigMod;

  factory ConfigMod.fromJson(Map<String, Object?> json) => _$ConfigModFromJson(json);
}

/// Modify config values.
@riverpod
class AppConfig extends _$AppConfig {
  late SharedPreferences prefs;

  @override
  ConfigMod build() {
    prefs = ref.watch(prefsProvider);
    return const ConfigMod();
  }

  void save(ConfigMod val) => state = val;

  void clear() => state = const ConfigMod();

  void toggleDarkMode(bool val) {
    prefs.setBool(prefKey('darkMode'), val);
    state = state.copyWith(darkMode: val);
  }

  void setFetchCount(int val) {
    prefs.setInt(prefKey('fetchCount'), val);
    state = state.copyWith(fetchCount: val);
  }

  void setTextSize(TextSize val) {
    prefs.setString(prefKey('textSize'), val.name);
    state = state.copyWith(textSize: val);
  }

  void setGridSize(GridSize val) {
    prefs.setString(prefKey('gridSize'), val.name);
    state = state.copyWith(gridSize: val);
  }
}
