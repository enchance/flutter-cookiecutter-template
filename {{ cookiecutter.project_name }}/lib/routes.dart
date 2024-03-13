import 'package:cookiesrc/core/auth/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'core/core.dart';
import 'views/views.dart';

part 'routes.g.dart';

@riverpod
GoRouter routes(RoutesRef ref) {
  final authStream = ref.watch(authStreamProvider);
  final startupComplete = ref.watch(startupCompleteProvider);
  User? user = authStream.valueOrNull;
  bool isAuth = user != null;

  return GoRouter(
      initialLocation: '/index',
      redirect: (context, state) {
        final guestUris = [
          '/index',
          '/index/auth',
          '/index/auth/signin',
          '/index/auth/register',
          '/index/auth/reset',
        ];
        bool isAuthenticating = guestUris.contains(state.matchedLocation);

        // TODO: Onbaording here
        if (!isAuth) return isAuthenticating ? null : '/index'; // User not auth
        if (isAuthenticating && startupComplete) return '/';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (_, state) => const HomeView(),
        ),
        GoRoute(
          path: '/index',
          name: 'index',
          builder: (_, state) => const IndexView(),
          routes: [
            GoRoute(
                path: 'auth',
                name: 'auth',
                builder: (_, state) => const AuthSelectionView(),
                routes: [
                  GoRoute(
                    path: 'signin',
                    name: 'signin',
                    builder: (_, state) => const EmailSignInView(),
                  ),
                  GoRoute(
                    path: 'register',
                    name: 'register',
                    builder: (_, state) => const RegisterView(),
                  ),
                  GoRoute(
                    path: 'reset',
                    name: 'reset',
                    builder: (_, state) => const ResetPasswordView(),
                  ),
                ]),
          ],
        ),
        GoRoute(
          path: '/startup',
          name: 'startup',
          builder: (_, state) => const StartupView(),
        ),
      ]);
}
