import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';


class Settings {
  // Layout
  final double padx = 20;
  final double radius = 5;
  final double maxwidth = 400;
  final double maxwidthex = 550;    // Bottomsheet
  final double bottomGap = 50;

  // Content
  final String country = 'PH';
}

@Riverpod(keepAlive: true)
Settings settings(SettingsRef ref) => Settings();


/// Model for all app settings. Making this @unfreezed is useless since
/// rebuilds are triggered when state is reassigned _not_ when it's mutated.
/// Place all methods in [AppSettings] provider since you need access
/// to [state].
///
/// No defaults needed. All defaults will come from [SharedPreferences].
/// Check [initPrefs] to see what they are.
///
/// If you add more properties to this model then update [initPrefs] and
/// [AppSettings].
@freezed
class ApplicationSettings with _$ApplicationSettings {
  // If you add to this also update initPrefs(), AppSettings
  // This must always be const and @freezed
  const factory ApplicationSettings({
    required bool darkmode,
    required String fontsize,
    @Default(10) int fetchCount,
  }) = _ApplicationSettings;

  factory ApplicationSettings.fromJson(Map<String, Object?> json)
  => _$ApplicationSettingsFromJson(json);
}