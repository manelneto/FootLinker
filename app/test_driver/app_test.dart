import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/authentication_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r'test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..stepDefinitions = [
      givenNotBeLoggedIn(),
      whenFillField(),
      whenTapButton(),
      thenBeLoggedIn(),
      thenNotBeLoggedIn(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  return GherkinRunner().execute(config);
}
