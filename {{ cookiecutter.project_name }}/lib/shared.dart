import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'core/routes.dart';

// TODO: Show dialog if anonymous user tries to sign-out saying data will be lost

Future<void> sharedMain({
  required Flavor flavor,
  required String title,
  required String appName,
}) async {
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return ErrorWidgetView(details);
  // };

  try {
    await dotenv.load(fileName: '.env');
    final emulatorEnv = dotenv.env['USE_EMULATOR'] ?? '';
    final useEmulator = ['true', 't', 'yes', 'y', '1'].contains(emulatorEnv.toLowerCase());

    // Initialize
    await Startup.initFirebase(useEmulator);
    final prefs = await SharedPreferences.getInstance();
    final settings = Settings(flavor: flavor, appName: appName);
    final packageInfo = await PackageInfo.fromPlatform();
    // prefs.clear();
    // await prefs.setBool(prefKey('showOnboarding'), false);

    FlutterNativeSplash.remove();
    runApp(ProviderScope(
      overrides: [
        useEmulatorProvider.overrideWith((_) => useEmulator),
        prefsProvider.overrideWithValue(prefs),
        packageInfoProvider.overrideWithValue(packageInfo),
        settingsProvider.overrideWithValue(settings),
        appConfigProvider.overrideWith(() => AppConfig()),
      ],
      child: App(title),
    ));
  } catch (err, _) {
    logger.e(err);
    rethrow;
  }
}

class App extends ConsumerWidget {
  final String title;

  const App(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(prefsProvider);
    final user = FirebaseAuth.instance.currentUser;
    final config = ref.watch(appConfigProvider);
    final routes = ref.watch(routesProvider(defaultRole, prefs));

    return MaterialApp.router(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 500, name: MOBILE),
          const Breakpoint(start: 501, end: 1100, name: TABLET),
          const Breakpoint(start: 1101, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      title: title,
      routerConfig: routes.valueOrNull ?? routerLoader(),
      theme: IndexTheme.light,
      debugShowCheckedModeBanner: false,
      darkTheme: IndexTheme.dark,
      themeMode:
          user == null ? ThemeMode.light : (config.darkMode ? ThemeMode.dark : ThemeMode.light),
    );
  }
}
