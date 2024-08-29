import 'package:flutter/material.dart';

import '../../data/datasources/local/local_storage_service.dart';

enum AuthStatus { checking, authenticated, unAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;

  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    // TODO: PETICIÓN HTTP
    _token = 'adkafañfalsñfjaf';
    LocalStorageService.prefs.setString('token', '$_token');
    // navegar a dashboard
    isAuthenticated();
  }

  Future<void> isAuthenticated() async {
    authStatus = AuthStatus.checking;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 2000));

    final token = LocalStorageService.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.unAuthenticated;
      notifyListeners();
    } else {
      authStatus = AuthStatus.authenticated;
      notifyListeners();
    }
  }
}
