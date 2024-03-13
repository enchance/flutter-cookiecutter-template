import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core.dart';
import 'conf.dart' as conf;

part 'settings.g.dart';

part 'settings.freezed.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  late SharedPreferences _prefs;

  @override
  SettingsMod build() {
    _prefs = ref.watch(prefsProvider);
    return const SettingsMod();
  }

  SharedPreferences get prefs => _prefs;

  // TODO: See if this works
  Future<void> _set<T>(Setting setting, T val) async {
    await _prefs.getAndSave<T>(setting, val);
    state = Function.apply(state.copyWith, [], {setting.name: val}.symbolizeKeys());
  }

  setDarkMode(bool val) async => await _set<bool>(Setting.darkMode, val);

  setLockPortrait(bool val) async => await _set<bool>(Setting.lockPortrait, val);

  setFontSize(FontSizes val) async {
    await _prefs.setString(Setting.fontSize.name, val.name);
    state = state.copyWith(fontSize: val);
  }
}

enum Setting {
  darkMode,
  fontSize,
  lockPortrait,
  allowNotifications,
}

@freezed
class SettingsMod with _$SettingsMod {
  static const String _apptitle = '{{ cookiecutter.project_name | title }}';
  static const String _appname = '{{ cookiecutter.project_name }}';
  static const double _padx = 16;
  static const double _pady = 16;
  static const double _radius = 5;
  static const double _maxWidth = 400;
  static const double _bottomGap = 50;
  static const double _topGap = 150;

  const SettingsMod._();

  const factory SettingsMod({
    // Also update `Startup.initPreferences()`, `config/conf.dart`
    @Default(conf.darkMode) final bool darkMode,
    @Default(conf.fontSize) final FontSizes fontSize,
    @Default(conf.lockPortrait) final bool lockPortrait,
    @Default(conf.allowNotifications) final bool allowNotifications,
  }) = _SettingsMod;

  // factory SettingsMod.fromJson(Map<String, Object?> json) => _$SettingsModFromJson(json);

  double get padx => _padx;

  String get apptitle => _apptitle;

  String get appname => _appname;

  double get pady => _pady;

  double get radius => _radius;

  double get maxWidth => _maxWidth;

  double get bottomGap => _bottomGap;

  double get topGap => _topGap;

  List<Breakpoint> get breakpoints => conf.responsiveBreakpoints;

  String get dateFormat => conf.dateFormat;
}
