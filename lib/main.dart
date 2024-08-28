import 'package:flutter/material.dart';

import 'external/di/inject.dart';
import 'external/router/app_router.dart';
import 'presentation/ui/layouts/auth/auth_layout.dart';

void main() {
  Inject().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      routerConfig: AppRouter.router,
      builder: (_, child) {
        return AuthLayout(child: child!);
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
        ),
      ),
    );
  }
}
