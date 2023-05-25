import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    surnameController.dispose();
  }

  Future signUp(
    BuildContext context,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      addUserDetails(
        user!,
        nameController.text.trim(),
        surnameController.text.trim(),
        emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: Center(
          child: Text(
            e.message!,
          ),
        ),
        duration: const Duration(
          seconds: 5,
        ),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

Future addUserDetails(
  User user,
  String name,
  String surname,
  String email,
) async {
  String? token = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic('schedule');
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'name': name,
    'surname': surname,
    'email': email,
    'token': token,
    'history': {},
    'schedule': {},
    'followed': {},
  });
}
