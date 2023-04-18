import 'package:app/view/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  //Verifica o correto funcionamento das credencias válidas
  testWidgets('Login with valid credentials', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginWidget(
            onClickedSignUp: () {},
          ),
        ),
      ),
    );

    // Find the email and password text fields
    final emailTextField = find.byType(TextFormField).at(0);
    final passwordTextField = find.byType(TextFormField).at(1);

    // Enter valid email and password
    await tester.enterText(emailTextField, 'manuel@gmail.com');
    await tester.enterText(passwordTextField, 'password');

    await tester.pumpAndSettle();
  });

//Verifica se as mensagens de erro exibidas após uso de credenciais erradas são as esperadas
testWidgets('Login with invalid credentials shows error message', (WidgetTester tester) async {
  // Build the widget
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: LoginWidget(
          onClickedSignUp: () {},
        ),
      ),
    ),
  );

  // Find the email and password text fields
  final emailTextField = find.byType(TextFormField).at(0);
  final passwordTextField = find.byType(TextFormField).at(1);

  // Enter invalid email and password
  await tester.enterText(emailTextField, 'pttys@gmail.com');
  await tester.enterText(passwordTextField, '123456');
  
    // Find and tap the login button
  final loginButton = find.widgetWithIcon(ElevatedButton, Icons.lock_open);
  await tester.tap(loginButton);

  // Wait for the widget tree to be rebuilt
  await tester.pumpAndSettle();

  // Check that the Snackbar with the error message is displayed
  expect(find.text('The password is invalid or the user does not have a password.'), findsOneWidget);
});
}
