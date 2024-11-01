import 'dart:developer';

import 'package:flutter/material.dart';

import '../../domain/auth_repository.dart';

enum AuthStatus { checking, authenticated, unAuthenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) {
    isAuthenticated();
  }

  bool? authenticatedState;

  AuthStatus authStatus = AuthStatus.checking;

  Future<void> login(String email, String password) async {
    await _authRepository.login(email, password);
    // navegar a dashboard
    isAuthenticated();
  }

  Future<void> signUp(String name, String user, String password) async {
    try {
      await _authRepository.signUp(name, user, password);

      isAuthenticated();
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  Future<void> isAuthenticated() async {
    try {
      authenticatedState = await _authRepository.isAuthenticated();
    } catch (error) {
      authenticatedState = false;
    }

    await Future.delayed(const Duration(milliseconds: 1000));

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
