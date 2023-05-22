import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/states/schedule_state.dart';
import 'package:flutter/material.dart';

class FollowedState extends ChangeNotifier {
  var followed = <Team>[];

  void toggleTeam(
    Team team,
    List<Match> nextMatches,
    ScheduleState scheduleState,
  ) {
    if (followed.contains(team)) {
      followed.remove(team);
      scheduleState.updateScheduleAfterUnfollow(followed);
    } else {
      followed.add(team);
      followed.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      scheduleState.updateScheduleAfterFollow(nextMatches);
    }
    notifyListeners();
  }
}
