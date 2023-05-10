import 'package:app/controller/register_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({
    super.key,
    required this.onClickedSignIn,
    required this.navigatorKey,
  });

  final Function() onClickedSignIn;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  RegisterController registerController = RegisterController();

  @override
  void dispose() {
    registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('registedWidget'),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: registerController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              key: const Key('nameFormField'),
              controller: registerController.nameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) => name != null && name.length < 3
                  ? 'O nome deve ter pelo menos 3 caracteres'
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const Key('surnameFormField'),
              controller: registerController.surnameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Apelido',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (surname) => surname != null && surname.length < 3
                  ? 'O apelido deve ter pelo menos 3 caracteres'
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const Key('emailFormField'),
              controller: registerController.emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'O e-mail inserido não é válido'
                      : null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              key: const Key('passwordFormField'),
              controller: registerController.passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 6
                  ? 'A senha deve ter pelo menos 6 caracteres'
                  : null,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              key: const Key('registerButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(
                Icons.lock,
                size: 30,
              ),
              label: const Text(
                'Registar',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () =>
                  registerController.signUp(context, widget.navigatorKey),
            ),
            const SizedBox(
              height: 40,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                text: 'Já tem uma conta? ',
                children: [
                  TextSpan(
                    semanticsLabel: 'haveAccount',
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    text: 'Entrar',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
