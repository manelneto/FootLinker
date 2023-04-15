import 'package:app/view/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
