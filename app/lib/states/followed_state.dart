import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/states/schedule_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowedState extends ChangeNotifier {
  var followed = <Team>[];

  void fetch() {
    followed.clear();
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
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
      Team team, List<Match> nextMatches, ScheduleState scheduleState,) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (followed.contains(team)) {
      followed.remove(team);
      user.collection('followed').doc(team.id.toString()).delete();
      scheduleState.updateScheduleAfterUnfollow(team, followed);
    } else {
      followed.add(team);
      followed.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      user.collection('followed').doc(team.id.toString()).set(team.toJson());
      scheduleState.updateScheduleAfterFollow(nextMatches);
    }
    notifyListeners();
  }
}
