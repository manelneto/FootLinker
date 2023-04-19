import 'package:flutter/material.dart';
import 'package:app/model/match.dart';

class HistoryState extends ChangeNotifier {
  var history = <Match>[];

  void addMatch(Match match) {
    if (!history.contains(match)) {
      history.add(match);
      history.sort(
            (b, a) => a.timestamp.compareTo(b.timestamp),
      );
      notifyListeners();
    }
  }

  void removeMatch(Match match) {
    if (history.remove(match)) {
      notifyListeners();
    }
  }
}
