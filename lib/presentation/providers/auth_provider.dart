import 'dart:developer';

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    // TODO: PETICIÓN HTTP
    _token = 'adkafañfalsñfjaf';
    log("jwt: $_token");
    // navegar a dashboard
    notifyListeners();
  }
}
