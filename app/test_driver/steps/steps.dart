import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric givenBeLoggedIn() {
  return given<FlutterWorld>('I am logged in', (context) async {
    final locator = find.byValueKey('homePage');
    if (await FlutterDriverUtils.isAbsent(context.world.driver, locator)) {
      final login = find.byValueKey('loginWidget');
      if (await FlutterDriverUtils.isAbsent(context.world.driver, login)) {
        final account = find.byValueKey('haveAccount');
        await FlutterDriverUtils.tap(context.world.driver, account);
      }
      final email = find.byValueKey('emailFormField');
      final password = find.byValueKey('passwordFormField');
      await FlutterDriverUtils.enterText(
        context.world.driver,
        email,
        'test@email.com',
      );
      await FlutterDriverUtils.enterText(
        context.world.driver,
        password,
        'password',
      );
      final button = find.byValueKey('loginButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        button,
      );
    }
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
      ),
      true,
    );
  });
}

StepDefinitionGeneric givenNotBeLoggedIn() {
  return given<FlutterWorld>('I am not logged in', (context) async {
    final locator = find.byValueKey('authenticationPage');
    if (await FlutterDriverUtils.isAbsent(
      context.world.driver,
      locator,
    )) {
      final profile = find.byValueKey('profileButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        profile,
      );
      final button = find.byValueKey('logoutButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        button,
      );
    }
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
      ),
      true,
    );
  });
}

StepDefinitionGeneric whenFillField() {
  return when2<String, String, FlutterWorld>(
      'I fill the {string} field with {string}',
      (input1, input2, context) async {
    final field = find.byValueKey('${input1}FormField');
    await FlutterDriverUtils.enterText(
      context.world.driver,
      field,
      input2,
    );
  });
}

StepDefinitionGeneric whenTapButton() {
  return when1<String, FlutterWorld>('I tap the {string} button',
      (input1, context) async {
    final locator = find.byValueKey('${input1}Button');
    await FlutterDriverUtils.tap(
      context.world.driver,
      locator,
    );
  });
}

StepDefinitionGeneric thenBeLoggedIn() {
  return then<FlutterWorld>('I am logged in', (context) async {
    final locator = find.byValueKey('homePage');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
      ),
      true,
    );
  });
}

StepDefinitionGeneric thenNotBeLoggedIn() {
  return then<FlutterWorld>('I am not logged in', (context) async {
    final authenticationLocator = find.byValueKey('authenticationPage');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        authenticationLocator,
      ),
      true,
    );
  });
}

StepDefinitionGeneric thenSeePage() {
  return then1<String, FlutterWorld>('I see {string} page',
      (input1, context) async {
    final locator = find.byValueKey('${input1}Page');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(context.world.driver, locator),
      true,
    );
  });
}
