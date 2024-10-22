// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      authProvider.login(email, password);
    } else {
      //TODO:
    }
  }
}
