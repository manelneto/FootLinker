import 'package:app/model/team.dart';
import 'package:flutter/material.dart';

class FollowedState extends ChangeNotifier {
  var followed = <Team>[];

  void addTeam(Team team) {
    if (!followed.contains(team)) {
      followed.add(team);
      followed.sort(
            (b, a) => a.name.compareTo(b.name),
      );
      notifyListeners();
    }
  }

  void removeTeam(Team team) {
    if (followed.remove(team)) {
      notifyListeners();
    }
  }
}
