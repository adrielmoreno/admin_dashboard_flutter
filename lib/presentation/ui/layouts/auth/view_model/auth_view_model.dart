import 'package:flutter/material.dart';

import '../../../../../data/datasources/local/secure_storage_service.dart';
import '../../../../../domain/auth_repository.dart';

enum AuthStatus { checking, authenticated, unAuthenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) {
    isAuthenticated();
  }

  bool? authenticatedState;

  String? _token;

  AuthStatus authStatus = AuthStatus.checking;

  login(String email, String password) async {
    // TODO: PETICIÓN HTTP
    _token = 'adkafañfalsñfjaf';
    await SecureStorageService.saveToken('$_token');
    // navegar a dashboard
    isAuthenticated();
  }

  Future<void> isAuthenticated() async {
    try {
      authenticatedState = await _authRepository.isAuthenticated();
    } catch (error) {
      authenticatedState = false;
    }

    authStatus = authenticatedState == true
        ? AuthStatus.authenticated
        : AuthStatus.unAuthenticated;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    isAuthenticated();
  }
}
