import 'dart:developer';

import '../../datasources/local/secure_storage_service.dart';

class AuthRemoteImpl {
  AuthRemoteImpl();

  Future<bool> isAuthenticated() async {
    try {
      final token = await SecureStorageService.getToken();

      return token != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String user, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    try {
      await SecureStorageService.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
