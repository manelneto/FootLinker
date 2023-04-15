import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    super.key,
    required this.onClickedSignIn,
  });

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            TextFormField(
              controller: firstNameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Primeiro Nome'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (firstName) =>
              firstName != null && firstName.length < 3
                  ? 'Digite um nome válido'
                  : null,
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: lastNameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Último Nome'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (lastName) =>
              lastName != null && lastName.length < 3
                  ? 'Digite um nome válido'
                  : null,
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: ageController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Idade'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (age) =>
              age != null &&  int.parse(age) < 12
                  ? 'Usuários precisam ser maiores de 12 anos'
                  : null,
            ),
            TextFormField(
              controller: phoneController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Telemóvel'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (phone) =>
              phone != null && phone.length != 9
                  ? 'Digite um número válido'
                  : null,
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                ? 'Digite um email válido'
                : null,
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) =>
              password != null && password.length < 6
              ? 'Senha deve ter pelo menos 6 caracteres'
              : null,
            ),
            TextFormField(
              controller: locationController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Distrito'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (distrito) =>
              distrito != null && distrito.length < 3
                  ? 'Digite um distrito válido'
                  : null,
            ),
            SizedBox(height: 4),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.lock_open, size: 32),
              label: Text(
                'Registrar',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signUp,
            ),
            SizedBox(height: 24),
            RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.green[400], fontSize: 18, fontWeight: FontWeight.bold),
                  text: 'Já possui uma conta?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Entrar',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return ;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      addUserDetails(user!, firstNameController.text.trim(), lastNameController.text.trim(), phoneController.text.trim(), emailController.text..trim(), locationController.text.trim(), int.parse(ageController.text.trim()));

    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

Future addUserDetails (User user,
    String firstName, String lastName, String phone, String email, String location, int age) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'first name': firstName,
    'last name': lastName,
    'phone': phone,
    'email': email,
    'location': location,
    'age': age,
  });
}