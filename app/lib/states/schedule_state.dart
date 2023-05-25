import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleState extends ChangeNotifier {
  var schedule = <Match>[];

  void fetch(DocumentReference<Map<String, dynamic>> user) {
    schedule.clear();
    user.collection('schedule').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Match match = Match.fromJson(docSnapshot.data());
        if (!schedule.contains(match)) {
          schedule.add(match);
        }
      }
      schedule.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
    });
  }

  bool toggleMatch(Match match, DocumentReference<Map<String, dynamic>> user) {
    if (schedule.contains(match)) {
      schedule.remove(match);
      user.collection('schedule').doc(match.id.toString()).delete();
      notifyListeners();
      return false;
    }

    schedule.add(match);
    schedule.sort(
      (a, b) => a.timestamp.compareTo(b.timestamp),
    );
    user.collection('schedule').doc(match.id.toString()).set(match.toJson());
    notifyListeners();
    return true;
  }

  void updateScheduleAfterFollow(
    List<Match> nextMatches,
    DocumentReference<Map<String, dynamic>> user,
  ) {
    for (Match match in nextMatches) {
      if (!schedule.contains(match)) {
        schedule.add(match);
        user
            .collection('schedule')
            .doc(match.id.toString())
            .set(match.toJson());
      }
    }
    schedule.sort(
      (a, b) => a.timestamp.compareTo(b.timestamp),
    );
    notifyListeners();
  }

  void updateScheduleAfterUnfollow(
    Team unfollowed,
    List<Team> followed,
    DocumentReference<Map<String, dynamic>> user,
  ) {
    final List<Match> matches = <Match>[];
    for (Match match in schedule) {
      if ((match.home == unfollowed && !followed.contains(match.away)) ||
          (match.away == unfollowed && !followed.contains(match.home))) {
        matches.add(match);
      }
    }

    schedule.removeWhere((match) => matches.contains(match));
    for (Match match in matches) {
      user.collection('schedule').doc(match.id.toString()).delete();
    }
    notifyListeners();
  }
}
