import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core/presentation/common/theme/constants/app_dimens.dart';
import 'navegation/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      routerConfig: AppRouter.router,
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.5)),
        ),
      ),
      builder: (context, child) => ResponsiveBreakpoints(
        breakpoints: const [
          Breakpoint(
            start: 0,
            end: AppDimens.minTableWidth,
            name: MOBILE,
          ),
          Breakpoint(
            start: AppDimens.minTableWidth,
            end: AppDimens.minDesktopWidth,
            name: TABLET,
          ),
          Breakpoint(
            start: AppDimens.minDesktopWidth,
            end: double.infinity,
            name: DESKTOP,
          ),
        ],
        child: child!,
      ),
    );
  }
}
