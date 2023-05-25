import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/states/schedule_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowedState extends ChangeNotifier {
  var followed = <Team>[];

  void fetch(DocumentReference<Map<String, dynamic>> user) {
    followed.clear();
    user.collection('followed').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Team team = Team.fromJson({'team': docSnapshot.data()});
        if (!followed.contains(team)) {
          followed.add(team);
        }
      }
      followed.sort(
        (a, b) => a.name.compareTo(b.name),
      );
    });
  }

  void toggleTeam(
    Team team,
    List<Match> nextMatches,
    ScheduleState scheduleState,
    DocumentReference<Map<String, dynamic>> user,
  ) {
    if (followed.contains(team)) {
      followed.remove(team);
      user.collection('followed').doc(team.id.toString()).delete();
      scheduleState.updateScheduleAfterUnfollow(team, followed, user);
    } else {
      followed.add(team);
      followed.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      user.collection('followed').doc(team.id.toString()).set(team.toJson());
      scheduleState.updateScheduleAfterFollow(nextMatches, user);
    }
    notifyListeners();
  }
}
