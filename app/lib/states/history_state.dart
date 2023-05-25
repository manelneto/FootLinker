import 'package:app/model/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryState extends ChangeNotifier {
  var history = <Match>[];

  void fetch() {
    history.clear();
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    user.collection('history').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Match match = Match.fromJson(docSnapshot.data());
        if (!history.contains(match)) {
          history.add(match);
        }
      }
      history.sort(
        (b, a) => a.timestamp.compareTo(b.timestamp),
      );
    });
  }

  bool toggleMatch(Match match) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (history.contains(match)) {
      history.remove(match);
      user.collection('history').doc(match.id.toString()).delete();
      notifyListeners();
      return false;
    }

    history.add(match);
    history.sort(
      (b, a) => a.timestamp.compareTo(b.timestamp),
    );
    user.collection('history').doc(match.id.toString()).set(match.toJson());
    notifyListeners();
    return true;
  }
}
