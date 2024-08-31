import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/sidemenu_provider.dart';
import '../../presentation/ui/layouts/auth/auth_layout.dart';
import '../../presentation/ui/layouts/dashboard/dashboard_layout.dart';
import '../../presentation/ui/layouts/splash/splash_layuot.dart';
import '../../presentation/ui/views/blank_view.dart';
import '../../presentation/ui/views/dashboard_view.dart';
import '../../presentation/ui/views/icons_view.dart';
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
    initialLocation: '/${DashboardView.route}',
    refreshListenable: getIt<AuthProvider>(),
    redirect: (context, state) {
      final authProvider = getIt<AuthProvider>();
      final sideMenuProvider = getIt<SideMenuProvider>();

      sideMenuProvider.setCurrentPageUrl(state.uri.toString().split('/').last);

      final authStatus = authProvider.authStatus;

      final isGoingToLoginOrRegister = state.uri.toString().contains('/auth');

      if (authStatus == AuthStatus.unAuthenticated &&
          !isGoingToLoginOrRegister) {
        return '/auth/${LoginView.route}';
      }

      if (authStatus == AuthStatus.authenticated && isGoingToLoginOrRegister) {
        return '/${DashboardView.route}';
      }

      return null;
    },
    routes: [
      // Splash
      _buildParent(path: SplashLayuot.route, child: const SplashLayuot()),

      // ------ Auth --------
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AuthLayout(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _authKey,
            routes: [
              _buildParent(
                path: 'auth',
                child: const LoginView(),
                routes: [
                  _buildChild(name: LoginView.route, child: const LoginView()),
                  _buildChild(
                      name: RegisterView.route, child: const RegisterView()),
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
                  path: DashboardView.route,
                  child: const DashboardView(),
                  routes: [
                    _buildChild(
                        name: IconsView.route, child: const IconsView()),
                    _buildChild(
                        name: BlankView.route, child: const BlankView()),
                  ]),
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
      path: '/$path',
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
