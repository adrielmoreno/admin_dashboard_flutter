import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/data/datasources/local/secure_storage_service.dart';

class AuthRemoteImpl {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteImpl(this._firebaseAuth);

  Future<bool> isAuthenticated() async {
    try {
      final token = await SecureStorageService.getToken();

      return token != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> login(String user, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: user, password: password);

      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        final token = await userCredential.user?.getIdToken();

        if (token != null) {
          await SecureStorageService.saveToken(token);
        }
      }
      // TODO: Catch errors
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await SecureStorageService.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseAuth
          .setLanguageCode(PlatformDispatcher.instance.locale.countryCode);

      await userCredential.user?.sendEmailVerification();
      await userCredential.user?.updateDisplayName(name);

      // TODO: Catch errors
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
