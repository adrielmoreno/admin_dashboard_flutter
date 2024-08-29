import 'package:flutter/material.dart';

import '../../data/datasources/local/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    // TODO: PETICIÓN HTTP
    _token = 'adkafañfalsñfjaf';
    LocalStorageService.prefs.setString('token', '$_token');
    // navegar a dashboard
    notifyListeners();
  }
}
