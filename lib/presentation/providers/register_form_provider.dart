import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../external/di/inject.dart';
import '../ui/layouts/auth/view_model/auth_view_model.dart';

class RegisterFormProvider extends ChangeNotifier {
  final _authProvider = getIt<AuthViewModel>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      _authProvider.signUp(name, email, password);
    } else {
      log('Invalid form');
    }
  }
}
