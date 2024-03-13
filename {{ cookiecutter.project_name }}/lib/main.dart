import 'package:cookiesrc/core/config/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes.dart';
import 'core/core.dart';
import 'core/config/config.dart' as conf;

// TODO: Merge AuthService to authProvider

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // // For testing CachedNetworkImage
  // if(!kDebugMode) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ]);
  //   DefaultCacheManager manager = DefaultCacheManager();
  //   manager.emptyCache();
  // }

  try {
    await dotenv.load(fileName: '.env');
    final emulatorEnv = dotenv.env['USE_EMULATOR'] ?? '';
    final useEmulator = ['true', 't', 'yes', 'y', '1'].contains(emulatorEnv.toLowerCase());

    // Initialize
    await StartupService.initFirebase(useEmulator);
    final prefs = await StartupService.initPrefs();
    // FlutterNativeSplash.remove();

    runApp(ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        useEmulatorProvider.overrideWith((ref) => useEmulator),
      ],
      child: const App(),
    ));
  } catch (err, _) {
    logger.d(err);
    rethrow;
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final routes = ref.watch(routesProvider);

    return MaterialApp.router(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: settings.breakpoints,
        child: child!,
      ),
      title: settings.apptitle,
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      theme: IndexTheme.light,
      darkTheme: IndexTheme.dark,
      // themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      themeMode: ThemeMode.light,
    );
  }
}
