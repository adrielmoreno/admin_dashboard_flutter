// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../external/di/inject.dart';
import 'auth_provider.dart';

class LoginFormProvider extends ChangeNotifier {
  final authProvider = getIt<AuthProvider>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      log('Form valid... Login');
      authProvider.login(email, password);
    } else {
      log('Invalid form');
    }
  }
}
