import 'package:get_it/get_it.dart';

import '../../data/auth/auth_data_impl.dart';
import '../../data/auth/remote/auth_remote_impl.dart';
import '../../domain/auth_repository.dart';
import '../../presentation/providers/sidemenu_provider.dart';
import '../../presentation/ui/layouts/auth/view_model/auth_view_model.dart';

final getIt = GetIt.instance;

class Inject {
  setup() {
    _setupAuth();
    _setupSideMenu();
  }

  _setupAuth() {
    getIt.registerFactory(() => AuthRemoteImpl());
    getIt.registerFactory<AuthRepository>(() => AuthDataImpl(getIt.get()));
    getIt.registerSingleton(AuthViewModel(getIt.get()));
  }

  _setupSideMenu() {
    getIt.registerLazySingleton<SideMenuProvider>(() => SideMenuProvider());
  }
}
