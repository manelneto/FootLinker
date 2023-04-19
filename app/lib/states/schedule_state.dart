import 'package:flutter/material.dart';
import 'package:app/model/match.dart';

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

  void removeMatch(Match match) {
    if (schedule.remove(match)) {
      notifyListeners();
    }
  }
}
