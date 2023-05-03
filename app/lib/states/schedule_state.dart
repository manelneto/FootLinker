import 'package:app/model/match.dart';
import 'package:flutter/material.dart';

class ScheduleState extends ChangeNotifier {
  var schedule = <Match>[];

  void addMatch(Match match) {
    if (!schedule.contains(match)) {
      schedule.add(match);
      schedule.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      notifyListeners();
    }
  }

  void addMatches( List<Match> matches) {
    for (Match match in matches) {
      addMatch(match);
    }
  }

  void removeMatches( List<Match> matches) {
    for (Match match in matches) {
      removeMatch(match);
    }
  }

  void removeMatch(Match match) {
    if (schedule.remove(match)) {
      notifyListeners();
    }
  }
}
