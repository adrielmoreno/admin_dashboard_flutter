import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/buttons/custom_outlined_button.dart';
import '../../common/buttons/link_text.dart';
import '../../common/inputs/custom_inputs.dart';
import '../../providers/register_form_provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);
        return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                  key: registerFormProvider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // name
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nombre el obligatorio';
                            }

                            return null;
                          },
                          onChanged: (value) =>
                              registerFormProvider.email = value.trim(),
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese su nombre',
                              label: 'Nombre',
                              icon: Icons.supervised_user_circle_sharp),
                        ),

                        const SizedBox(height: 20),

                        // Email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!EmailValidator.validate('${value?.trim()}')) {
                              return 'Email no válido';
                            }

                            return null;
                          },
                          onChanged: (value) =>
                              registerFormProvider.email = value.trim(),
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese su correo',
                              label: 'Email',
                              icon: Icons.email_outlined),
                        ),

                        const SizedBox(height: 20),

                        // Password
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su contraseña';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe de ser de 6 caractares';
                            }

                            return null;
                          },
                          onChanged: (value) =>
                              registerFormProvider.password = value,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '*********',
                              label: 'Contraseña',
                              icon: Icons.lock_outline_rounded),
                        ),

                        const SizedBox(height: 20),
                        CustomOutlinedButton(
                          onPressed: () {
                            registerFormProvider.validateForm();
                          },
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
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
