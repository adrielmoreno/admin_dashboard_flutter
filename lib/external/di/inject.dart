import 'package:get_it/get_it.dart';

import '../../presentation/providers/auth_provider.dart';

final getIt = GetIt.instance;

class Inject {
  setup() {
    _setupAuth();
  }

  _setupAuth() {
    getIt.registerSingleton(AuthProvider());
  }
}
