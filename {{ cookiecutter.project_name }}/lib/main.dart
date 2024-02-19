import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/core.dart';
import 'core/config/routes.dart';
import 'startup/startup.dart';


void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await dotenv.load(fileName: '.env');
    final emulatorEnv = dotenv.env['USE_EMULATOR'] ?? '';
    final useEmulator = ['true', 't', 'yes', 'y', '1'].contains(emulatorEnv.toLowerCase());

    // Initialize
    await Startup.initFirebase(useEmulator);
    final prefs = await Startup.initPreferences();

    FlutterNativeSplash.remove();

    runApp(ProviderScope(overrides: [
      prefsProvider.overrideWithValue(prefs),
      useEmulatorProvider.overrideWith((ref) => useEmulator),
    ], child: const App()));
  } catch (err, _) {
    logger.d(err);
    rethrow;
    // TODO: Error widget needed
  }
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final appsettings = ref.watch(appSettingsProvider);
    final routes = ref.watch(routesProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      theme: IndexTheme.light,
      darkTheme: IndexTheme.dark,
      themeMode: appsettings.darkmode ? ThemeMode.dark : ThemeMode.light,
      // themeMode: ThemeMode.dark,
    );
  }
}
