import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/auth/auth.dart';
import '../../views/views.dart';
import '../../organization/organization.dart';
import '../../branch/branch.dart';
import '../../components/components.dart';
import '../../startup/startup.dart';
import '../../accounts/accounts.dart';

part 'routes.g.dart';

enum RouteName {
  signin,
  home,
  scan,
  session,
  admin,
  settings,
  startup,
}

@riverpod
GoRouter routes(RoutesRef ref) {
  final authStream = ref.watch(authStreamProvider);
  final startupComplete = ref.watch(startupCompleteProvider);
  Role role = ref.watch(roleProvider);
  bool isAuth = authStream.valueOrNull != null;

  return GoRouter(
    initialLocation: '/signin',
    redirect: (context, state) {
      final bool onSignin = state.matchedLocation == '/signin';
      final bool onResetPassword = state.matchedLocation == '/reset-password'; // Not in use
      final bool isAuthenticating = onSignin || onResetPassword;

      if (!isAuth) return isAuthenticating ? null : '/signin';

      // User is authenticated
      if (isAuthenticating) return startupComplete ? '/' : '/startup';
      return null;
    },
    routes: [
      GoRoute(
        path: '/signin',
        name: RouteName.signin.name,
        builder: (_, state) => const SigninView(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (_, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: '/startup',
        name: RouteName.startup.name,
        builder: (_, state) => const StartupView(),
      ),

      /* Auth views */
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell, role: role);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: RouteName.home.name,
                builder: (_, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scan',
                name: RouteName.scan.name,
                builder: (_, state) => const ScanView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/session',
                name: RouteName.session.name,
                builder: (_, state) => const SessionView(),
              ),
            ],
          ),
          if (role == Role.founder)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/admin',
                  name: RouteName.admin.name,
                  builder: (_, state) => const AdminView(),
                ),
              ],
            ),
        ],
      ),
      GoRoute(
        path: '/branch/create',
        name: 'create-branch',
        builder: (_, state) => const BranchCreateView(),
      ),
      GoRoute(
        path: '/branch/edit',
        name: 'edit-branch',
        builder: (_, state) => const BranchUpdateView(),
      ),
      GoRoute(
        path: '/org/create',
        name: 'create-org',
        builder: (_, state) => const OrgCreateView(),
      ),
      GoRoute(
        path: '/org/edit',
        name: 'edit-org',
        builder: (_, state) => const OrgUpdateView(),
      ),
      GoRoute(
        path: '/account/add',
        name: 'add-account',
        builder: (_, state) => const AccountsCreate(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteName.settings.name,
        builder: (_, state) => const SettingsView(),
      ),
    ],
  );
}
