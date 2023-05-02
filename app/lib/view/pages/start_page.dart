import 'package:app/view/pages/app_page.dart';
import 'package:app/view/pages/authentication_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('startPage'),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AppPage(navigatorKey: navigatorKey);
          } else {
            return AuthenticationPage(navigatorKey: navigatorKey);
          }
        },
      ),
    );
  }
}
