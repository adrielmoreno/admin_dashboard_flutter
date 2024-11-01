// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/di/inject.dart';
import '../view_model/auth_view_model.dart';

class LoginFormProvider extends ChangeNotifier {
  final authProvider = getIt<AuthViewModel>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email =
      TextEditingController(text: kDebugMode ? 'amorenorosso@gmail.com' : '');
  TextEditingController password =
      TextEditingController(text: kDebugMode ? '12345678' : '');

  validateForm() {
    if (formKey.currentState!.validate()) {
      authProvider.login(email.text, password.text);
    } else {
      //TODO:
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
