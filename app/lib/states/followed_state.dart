import 'package:app/model/team.dart';
import 'package:flutter/material.dart';

class FollowedState extends ChangeNotifier {
  var followed = <Team>[];

  void toggleTeam(Team team) {
    if (followed.contains(team)) {
      followed.remove(team);
    } else {
      followed.add(team);
    }
    notifyListeners();
  }
}
