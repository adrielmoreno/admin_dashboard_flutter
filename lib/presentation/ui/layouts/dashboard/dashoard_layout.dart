import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({
    super.key,
    required this.navigationShell,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard'),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}
