import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../buttons/custom_outlined_button.dart';
import '../buttons/link_text.dart';
import '../inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
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
                    hint: 'Ingrese su nombre',
                    label: 'Nombre',
                    icon: Icons.supervised_user_circle_sharp),
              ),

              const SizedBox(height: 20),

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
                text: 'Crear cuenta',
              ),

              const SizedBox(height: 20),
              LinkText(
                text: 'Ir al login',
                onPressed: () {
                  context.goNamed('login');
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}
