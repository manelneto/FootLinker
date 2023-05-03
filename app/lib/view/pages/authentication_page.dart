import 'package:app/view/widgets/login_widget.dart';
import 'package:app/view/widgets/register_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
      key: const Key('authenticationPage'),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
