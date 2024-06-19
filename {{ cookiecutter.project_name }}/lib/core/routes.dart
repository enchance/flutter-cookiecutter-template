import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home_view.dart';
import '../views/preloader_view.dart';
import '../views/settings_view.dart';
import '../views/onboarding_view.dart';
import 'core.dart';

part 'routes.g.dart';

@riverpod
Future<GoRouter> routes(RoutesRef ref, Role role, SharedPreferences prefs) async {
  final authstream = ref.watch(authStreamProvider);
  final settings = ref.watch(settingsProvider);
  final user = authstream.valueOrNull;
  bool isReady = false;

  // Run all required resources here so it won't jump to / until everything is ready
  if (user != null) {
    final account = await AccountService.fetchOrCreate(user);
    logger.d(account);
    if (account != null) {
      final success = await ref.read(authProvider.notifier).fetchResources(account);
      ref.read(accountProvider.notifier).update((_) => account);
      ref.read(authPendingProvider.notifier).update((_) => '');
      ref.read(signOutTextProvider.notifier).update((_) => null);
      isReady = success;
    }
  }

  return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        bool isAuthenticating = [
          '/authwall/signin',
          '/authwall/register',
          '/authwall/resetpass',
        ].contains(state.matchedLocation);
        bool showAuthWall = prefs.getBool('showAuthWall') ?? settings.authWallAsDefault;
        bool showOnboarding = prefs.getBool(prefKey('showOnboarding')) ?? true;

        if (!isReady) {
          if (showOnboarding) return '/onboarding';
          if (isAuthenticating) return null;
          if (showAuthWall) return '/authwall';
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (_, state) => const OnboardingView(),
        ),
        GoRoute(
            path: '/authwall',
            name: 'authwall',
            builder: (_, state) => const AuthWallView(),
            routes: [
              GoRoute(
                path: 'signin',
                name: 'signin',
                builder: (_, state) => const EmailSignInForm(),
              ),
              GoRoute(
                path: 'register',
                name: 'register',
                builder: (_, state) => const RegisterForm(),
              ),
              GoRoute(
                path: 'resetpass',
                name: 'resetpass',
                builder: (_, state) => const ResetPasswordForm(),
              ),
            ]),
        GoRoute(
          path: '/',
          builder: (_, state) => const HomeView(),
          routes: [
            GoRoute(
              path: 'account',
              name: 'account',
              builder: (_, state) => const AccountView(),
              routes: [
                GoRoute(
                  path: 'edit',
                  name: 'editprofile',
                  builder: (_, state) => const EditProfileForm(),
                ),
              ]
            ),
            GoRoute(
              path: 'settings',
              name: 'settings',
              builder: (_, state) => const SettingsView(),
            ),
          ],
        ),
      ]);
}

GoRouter routerLoader() {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (_, state) => const PreloaderView(),
    )
  ]);
}
