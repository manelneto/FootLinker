import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric longPressTileNTimesStep() {
  return when2<String, int, FlutterWorld>(
    'I long press the {string} tile {int} times',
        (key, count, context) async {
      final locator = find.byValueKey(key);
      for (var i = 0; i < count; i += 1) {
        await FlutterDriverUtils.longPress(context.world.driver!, locator);
      }
    },
  );
}
