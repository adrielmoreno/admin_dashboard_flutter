import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../core/data/db_services/firebase_services.dart';
import '../../core/presentation/ui/layouts/sidebar/providers/sidemenu_provider.dart';
import '../../features/auth/data/auth_data_impl.dart';
import '../../features/auth/data/remote/auth_remote_impl.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/presentation/view_model/auth_view_model.dart';
import '../../features/category/data/categories_data_impl.dart';
import '../../features/category/data/remote/categories_remote_impl.dart';
import '../../features/category/data/repositories/categories_repository.dart';
import '../../features/category/presentation/view_model/categories_view_model.dart';
import '../../features/product/data/products_data_impl.dart';
import '../../features/product/data/remote/products_remote_impl.dart';
import '../../features/product/data/repositories/products_repository.dart';
import '../../features/product/presentation/view_model/products_view_model.dart';
import '../../features/suplier/data/remote/suppliers_remote_impl.dart';
import '../../features/suplier/data/repositories/suppliers_repository.dart';
import '../../features/suplier/data/suppliers_data_impl.dart';
import '../../features/suplier/presentation/view_model/suppliers_view_model.dart';

final getIt = GetIt.instance;

class Inject {
  setup() {
    _setupDB();
    _setupAuth();
    _setupSideMenu();
    _setupCategories();
    _setupProducts();
    _setupSuppliers();
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

  _setupProducts() {
    getIt.registerFactory<ProductsRemoteImpl>(
        () => ProductsRemoteImpl(getIt.get()));
    getIt.registerFactory<ProductsRepository>(
        () => ProductsDataImpl(getIt.get()));
    getIt.registerSingleton(ProductsViewModel(getIt.get()));
  }

  _setupSuppliers() {
    getIt.registerFactory<SuppliersRemoteImpl>(
        () => SuppliersRemoteImpl(getIt.get()));
    getIt.registerFactory<SuppliersRepository>(
        () => SuppliersDataImpl(getIt.get()));
    getIt.registerSingleton(SuppliersViewModel(getIt.get()));
  }

  _setupSideMenu() {
    getIt.registerLazySingleton<SideMenuProvider>(() => SideMenuProvider());
  }
}
