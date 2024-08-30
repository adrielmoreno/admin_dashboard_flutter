import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/ui/layouts/auth/auth_layout.dart';
import '../../presentation/ui/layouts/dashboard/dashboard_layout.dart';
import '../../presentation/ui/layouts/splash/splash_layuot.dart';
import '../../presentation/ui/views/dashboard_view.dart';
import '../../presentation/ui/views/login_view.dart';
import '../../presentation/ui/views/no_page_found_view.dart';
import '../../presentation/ui/views/register_view.dart';
import '../di/inject.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _authKey = GlobalKey<NavigatorState>();
final _dashboardKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    refreshListenable: getIt<AuthProvider>(),
    redirect: (context, state) {
      final authProvider = getIt<AuthProvider>();

      final authStatus = authProvider.authStatus;

      final isGoingToLoginOrRegister = state.uri.toString().contains('/auth');

      if (authStatus == AuthStatus.checking) {
        return state.uri.toString() != '/splash' ? '/splash' : null;
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingToLoginOrRegister || state.uri.toString() == '/splash') {
          return '/dashboard';
        }
      }

      if (authStatus == AuthStatus.unAuthenticated) {
        if (!isGoingToLoginOrRegister &&
            state.uri.toString() != '/auth/login') {
          return '/auth/login';
        }
      }

      return null;
    },
    routes: [
      // Splash
      _buildParent(path: '/splash', child: const SplashLayuot()),

      // ------ Auth --------
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AuthLayout(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _authKey,
            routes: [
              _buildParent(
                path: '/auth',
                child: const LoginView(),
                routes: [
                  _buildChild(name: 'login', child: const LoginView()),
                  _buildChild(name: 'register', child: const RegisterView()),
                ],
              ),
            ],
          )
        ],
      ),

      // ------ Dashboard --------
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            DashboardLayout(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardKey,
            routes: [
              _buildParent(
                path: '/dashboard',
                child: const DashboardView(),
              ),
            ],
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const NoPageFoundView(),
  );

  static GoRoute _buildChild({
    required String name,
    required Widget child,
  }) {
    return GoRoute(
      name: name,
      path: name,
      pageBuilder: (context, state) => _fadeTransition(child),
    );
  }

  static GoRoute _buildParent({
    required String path,
    required Widget child,
    List<RouteBase>? routes,
  }) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => _fadeTransition(child),
      routes: routes ?? [],
    );
  }

  static CustomTransitionPage<dynamic> _fadeTransition(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
