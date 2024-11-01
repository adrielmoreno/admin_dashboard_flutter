import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../navbar/navbar.dart';
import '../sidebar/providers/sidemenu_provider.dart';
import '../sidebar/sidebar.dart';

class DashboardLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardLayout({super.key, required this.navigationShell});

  @override
  State createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                // Sidebar
                if (breakpoint.largerThan(MOBILE)) const Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      // Navbar
                      const Navbar(),

                      // View
                      Expanded(
                          child: Container(
                        child: widget.navigationShell,
                      )),
                    ],
                  ),
                )
              ],
            ),
            if (breakpoint.smallerThan(TABLET))
              AnimatedBuilder(
                animation: SideMenuProvider.menuController,
                builder: (context, _) => Stack(
                  children: [
                    if (SideMenuProvider.isOpen)
                      Opacity(
                        opacity: SideMenuProvider.opacity.value,
                        child: GestureDetector(
                          onTap: SideMenuProvider.closeMenu,
                          child: Container(
                            width: breakpoint.screenWidth,
                            height: breakpoint.screenHeight,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(SideMenuProvider.movement.value, 0),
                      child: const Sidebar(),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
