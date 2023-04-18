import 'package:app/view/widgets/login_widget.dart';
import 'package:app/view/widgets/register_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  Widget signInOrUp() {
    if (isLogin) {
      return LoginWidget(
        onClickedSignUp: toggle,
        navigatorKey: widget.navigatorKey,
      );
    }
    return RegisterWidget(
      onClickedSignIn: toggle,
      navigatorKey: widget.navigatorKey,
    );
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
      body: signInOrUp(),
    );
  }

  void toggle() {
    return setState(() {
      isLogin = !isLogin;
    });
  }
}
