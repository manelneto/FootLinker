import 'package:flutter/material.dart';

import '../widgets/login_widget.dart';
import '../widgets/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  Widget SignInOrUp() {
    if (this.isLogin) return LoginWidget(onClickedSignUp: toggle);
    return SignUpWidget(onClickedSignIn: toggle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FootLinker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SignInOrUp(),
    );
  }

  void toggle() {
    return setState(() {
      isLogin = !isLogin;
    });
  }
}
