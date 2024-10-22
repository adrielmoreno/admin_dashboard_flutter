import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'data/datasources/local/local_storage_service.dart';
import 'external/di/inject.dart';
import 'external/router/app_router.dart';
import 'presentation/common/theme/constants/app_dimens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.configurePrefs();

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
