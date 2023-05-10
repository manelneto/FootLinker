import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r'test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..stepDefinitions = [
      givenBeLoggedIn(),
      givenNotBeLoggedIn(),
      whenFillField(),
      whenTapButton(),
      thenBeLoggedIn(),
      thenNotBeLoggedIn(),
      thenSeePage(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart'
    ..defaultTimeout = const Duration(minutes: 2)
    ..flutterBuildTimeout = const Duration(minutes: 2);
  return GherkinRunner().execute(config);
}
