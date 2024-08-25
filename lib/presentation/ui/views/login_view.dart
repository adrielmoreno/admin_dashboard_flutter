import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/buttons/custom_outlined_button.dart';
import '../../common/buttons/link_text.dart';
import '../../common/inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
              child: Column(
            children: [
              // Email
              TextFormField(
                // validator: (),
                style: const TextStyle(color: Colors.white),
                decoration: CustomInputs.loginInputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Email',
                    icon: Icons.email_outlined),
              ),

              const SizedBox(height: 20),

              // Password
              TextFormField(
                // validator: (),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: CustomInputs.loginInputDecoration(
                    hint: '*********',
                    label: 'Contraseña',
                    icon: Icons.lock_outline_rounded),
              ),

              const SizedBox(height: 20),
              CustomOutlinedButton(
                onPressed: () {},
                text: 'Ingresar',
              ),

              const SizedBox(height: 20),
              LinkText(
                text: 'Nueva cuenta',
                onPressed: () {
                  context.goNamed('register');
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
