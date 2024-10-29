import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../data/auth/auth_data_impl.dart';
import '../../data/auth/remote/auth_remote_impl.dart';
import '../../data/categories/categories_data_impl.dart';
import '../../data/categories/remote/categories_remote_impl.dart';
import '../../data/db_services/firebase_services.dart';
import '../../domain/auth_repository.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../presentation/providers/sidemenu_provider.dart';
import '../../presentation/ui/layouts/auth/view_model/auth_view_model.dart';
import '../../presentation/ui/views/categories/view_model/categories_view_model.dart';

final getIt = GetIt.instance;

class Inject {
  setup() {
    _setupDB();
    _setupAuth();
    _setupSideMenu();
    _setupCategories();
  }

  _setupAuth() {
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerFactory(() => AuthRemoteImpl(getIt.get()));
    getIt.registerFactory<AuthRepository>(() => AuthDataImpl(getIt.get()));
    getIt.registerSingleton(AuthViewModel(getIt.get()));
  }

  _setupDB() {
    getIt.registerLazySingleton(() => FirebaseServices());
  }

  _setupCategories() {
    getIt.registerFactory<CategoriesRemoteImpl>(
        () => CategoriesRemoteImpl(getIt.get()));
    getIt.registerFactory<CategoriesRepository>(
        () => CategoriesDataImpl(getIt.get()));
    getIt.registerSingleton(CategoriesViewModel(getIt.get()));
  }

  _setupSideMenu() {
    getIt.registerLazySingleton<SideMenuProvider>(() => SideMenuProvider());
  }
}
