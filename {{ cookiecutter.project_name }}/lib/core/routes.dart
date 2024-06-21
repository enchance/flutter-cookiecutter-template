import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/placeholder_view.dart';
import 'core.dart';
import '../views/home_view.dart';
import '../views/settings_view.dart';
import '../views/onboarding_view.dart';
import '../components/components.dart';

part 'routes.g.dart';

@riverpod
Future<GoRouter> routes(RoutesRef ref, Role role, SharedPreferences prefs) async {
  final settings = ref.watch(settingsProvider);
  final authstream = ref.watch(authStreamProvider);
  final authaccount = authstream.valueOrNull ?? const AuthAccount();
  bool isReady = false;

  // Run all required resources here so it won't jump to / until everything is ready
  if (authaccount.hasAccount) {
    final Account account = authaccount.account!;
    try {
      final success = await ref.read(authProvider.notifier).fetchResources(account);
      ref.read(authAccountProvider.notifier).update((_) => authaccount);
      ref.read(accountProvider.notifier).update((_) => account);
      ref.read(authPendingProvider.notifier).update((_) => '');
      ref.read(signOutTextProvider.notifier).update((_) => null);
      isReady = success;
    } catch (err, _) {
      logger.e(err);
      isReady = false;
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
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNavBar(
          navigationShell: navigationShell,
          role: role,
          // feature: feature,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (_, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/place1',
                builder: (_, state) => const PlaceholderView('API'),
              ),
            ],
          ),
          if (role == Role.starter)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/place2',
                  builder: (_, state) => const PlaceholderView('Search'),
                ),
              ],
            ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/place3',
                builder: (_, state) => const PlaceholderView('Autumn'),
              ),
            ],
          ),
          // if (feature.isPopol && role == Role.staff)
          //   StatefulShellBranch(
          //     routes: [
          //       GoRoute(
          //           path: '/branch/select/tab',
          //           name: 'branch-select-tab',
          //           builder: (_, state) => const BranchSelectView()),
          //     ],
          //   ),
        ],
      ),
      GoRoute(
          path: '/account',
          name: 'account',
          builder: (_, state) => const AccountView(),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'editprofile',
              builder: (_, state) => const EditProfileForm(),
            ),
          ]),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_, state) => const SettingsView(),
      ),
    ],
  );
}

GoRouter routerLoader() {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (_, state) => const PreloaderView(),
    )
  ]);
}
