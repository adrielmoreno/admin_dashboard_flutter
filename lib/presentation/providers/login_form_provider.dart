import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      log('Form valid... Login');
      log(email);
      log(password);
    } else {
      log('Invalid form');
    }
  }
}
