import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/di/inject.dart';
import '../view_model/auth_view_model.dart';

class RegisterFormProvider extends ChangeNotifier {
  final _authProvider = getIt<AuthViewModel>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      _authProvider.signUp(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
    } else {
      log('Invalid form');
    }
  }
}
