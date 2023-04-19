import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric givenBeLoggedIn() {
  return given<FlutterWorld>('I am logged in', (context) async {
    final locator = find.byValueKey('profile');
    if (!await FlutterDriverUtils.isPresent(context.world.driver, locator)) {
      final email = find.byValueKey('email');
      final password = find.byValueKey('password');
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
      final button = find.byValueKey('login');
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
    final locator = find.byValueKey('profile');
    if (await FlutterDriverUtils.isPresent(
      context.world.driver,
      locator,
    )) {
      final button = find.byValueKey('logout');
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
      false,
    );
  });
}

StepDefinitionGeneric whenFillField() {
  return when2<String, String, FlutterWorld>(
      'I fill the {string} field with {string}',
      (input1, input2, context) async {
    final field = find.byValueKey(input1);
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
    final locator = find.byValueKey(input1);
    await FlutterDriverUtils.tap(
      context.world.driver,
      locator,
    );
  });
}

StepDefinitionGeneric thenBeLoggedIn() {
  return then<FlutterWorld>('I am logged in', (context) async {
    final locator = find.byValueKey('profile');
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
    final profileLocator = find.byValueKey('profile');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        profileLocator,
      ),
      false,
    );
    final authenticationLocator = find.byValueKey('authentication');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
        context.world.driver,
        authenticationLocator,
      ),
      false,
    );
  });
}

StepDefinitionGeneric thenSee() {
  return then1<String, FlutterWorld>('I see {string}', (input1, context) async {
    final locator = find.byValueKey('${input1}Page');
    context.expectMatch(
      await FlutterDriverUtils.isPresent(context.world.driver, locator),
      true,
    );
  });
}
