import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';
part 'providers.g.dart';


enum AppSetting {darkmode, fontsize}


@Riverpod(keepAlive: true)
SharedPreferences prefs(PrefsRef ref) {
  throw UnimplementedError('MISSING_PROVIDER');
}


final currentScreenNameProvider = StateProvider<ViewName>((ref) => ViewName.none);


/// Provider for app settings. Create methods that replace [state] here.
/// Don't put methods in [ApplicationSettings] since you don't have
/// access to [state] there but you do here.
@Riverpod(keepAlive: true)
class AppSettings extends _$AppSettings {
  late SharedPreferences _prefs;

  @override
  ApplicationSettings build() {
    _prefs = ref.watch(prefsProvider);

    final appsettings = ApplicationSettings(
      // Prepopulated at startup in initPrefs()
      darkmode: _prefs.getBool(AppSetting.darkmode.name)!,
      fontsize: _prefs.getString(AppSetting.fontsize.name)!,
    );

    return appsettings;
  }

  toggleDarkMode(bool val) {
    if(state.darkmode == val) return;
    _prefs.setBool(AppSetting.darkmode.name, val);
    state = state.copyWith(darkmode: val);
  }

  /// Not in use
  setFontSize(String val) {
    if(state.fontsize == val) return;
    _prefs.setString(AppSetting.fontsize.name, val);
    state = state.copyWith(fontsize: val);
  }
}
