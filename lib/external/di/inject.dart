import 'package:get_it/get_it.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/sidemenu_provider.dart';

final getIt = GetIt.instance;

class Inject {
  setup() {
    _setupAuth();
    _setupSideMenu();
  }

  _setupAuth() {
    getIt.registerSingleton(AuthProvider());
  }

  _setupSideMenu() {
    getIt.registerLazySingleton<SideMenuProvider>(() => SideMenuProvider());
  }
}
