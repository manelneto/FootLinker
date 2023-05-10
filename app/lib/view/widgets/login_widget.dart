import 'package:app/controller/login_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
    required this.onClickedSignUp,
    required this.navigatorKey,
  });

  final VoidCallback onClickedSignUp;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  LoginController loginController = LoginController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('loginWidget'),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              key: const Key('emailFormField'),
              controller: loginController.emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'E-mail'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'O e-mail inserido não é válido'
                      : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('passwordFormField'),
              controller: loginController.passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => password != null && password.length < 6
                  ? 'A senha deve ter pelo menos 6 caracteres'
                  : null,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              key: const Key('loginButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.lock, size: 30),
              label: const Text(
                'Entrar',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () =>
                  loginController.signIn(context, widget.navigatorKey),
            ),
            const SizedBox(height: 40),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                text: 'Ainda não criou uma conta? ',
                children: [
                  TextSpan(
                    semanticsLabel: 'createAccount',
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Registe-se!',
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
