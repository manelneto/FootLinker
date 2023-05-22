import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:flutter/material.dart';

class ScheduleState extends ChangeNotifier {
  var schedule = <Match>[];
/*
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
*/
  bool toggleMatch(Match match) {
    if (schedule.contains(match)) {
      schedule.remove(match);
      notifyListeners();
      return false;
    }

    schedule.add(match);
    schedule.sort(
          (a, b) => a.timestamp.compareTo(b.timestamp),
    );
    notifyListeners();
    return true;
  }

  void updateScheduleAfterFollow(List<Match> nextMatches) {
    for (Match match in nextMatches) {
      if (!schedule.contains(match)) {
        schedule.add(match);
        schedule.sort(
              (a, b) => a.timestamp.compareTo(b.timestamp),
        );
      }
    }
    notifyListeners();
  }

  void updateScheduleAfterUnfollow(List<Team> followed) {
    var newSchedule = <Match>[];
    for (Match match in schedule) {
      if (followed.contains(match.home) || followed.contains(match.away)) {
        newSchedule.add(match);
      }
    }
    schedule = newSchedule;
    notifyListeners();
  }
}
