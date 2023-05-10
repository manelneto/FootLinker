import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric givenBeLoggedIn() {
  return given<FlutterWorld>('I am logged in', (context) async {
    final locator = find.byValueKey('homePage');
    if (await FlutterDriverUtils.isAbsent(
      context.world.driver,
      locator,
      timeout: const Duration(minutes: 1),
    )) {
      final login = find.byValueKey('loginWidget');
      if (await FlutterDriverUtils.isAbsent(
        context.world.driver,
        login,
        timeout: const Duration(minutes: 1),
      )) {
        final account = find.bySemanticsLabel('haveAccount');
        await FlutterDriverUtils.tap(context.world.driver, account);
      }
      final email = find.byValueKey('emailFormField');
      final password = find.byValueKey('passwordFormField');
      await FlutterDriverUtils.enterText(
        context.world.driver,
        email,
        'test@email.com',
        timeout: const Duration(minutes: 1),
      );
      await FlutterDriverUtils.enterText(
        context.world.driver,
        password,
        'password',
        timeout: const Duration(minutes: 1),
      );
      final button = find.byValueKey('loginButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        button,
        timeout: const Duration(minutes: 1),
      );
    }
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
        timeout: const Duration(minutes: 1),
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
      timeout: const Duration(minutes: 1),
    )) {
      final profile = find.byValueKey('profileButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        profile,
        timeout: const Duration(minutes: 1),
      );
      final button = find.byValueKey('logoutButton');
      await FlutterDriverUtils.tap(
        context.world.driver,
        button,
        timeout: const Duration(minutes: 1),
      );
    }
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
        timeout: const Duration(minutes: 1),
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
      timeout: const Duration(minutes: 1),
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
      timeout: const Duration(minutes: 1),
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
        timeout: const Duration(minutes: 1),
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
        timeout: const Duration(minutes: 1),
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
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        locator,
        timeout: const Duration(minutes: 1),
      ),
      true,
    );
  });
}
