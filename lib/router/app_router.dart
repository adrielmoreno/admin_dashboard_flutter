import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/views/login_view.dart';
import '../ui/views/no_page_found_view.dart';
import '../ui/views/register_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth/login',
    routes: [
      // Auth
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginView()),
        routes: [
          _buildChild(name: 'login', child: const LoginView()),
          _buildChild(name: 'register', child: const RegisterView()),
        ],
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          // Aquí se colocaría el widget del dashboard
          return const Placeholder(); // Reemplaza con el widget correcto
        },
      ),
    ],
    errorBuilder: (context, state) => const NoPageFoundView(),
  );

// Methods
  static GoRoute _buildChild({
    required String name,
    required Widget child,
  }) {
    return GoRoute(
      name: name,
      path: name,
      pageBuilder: (context, state) => NoTransitionPage(child: child),
    );
  }
}
