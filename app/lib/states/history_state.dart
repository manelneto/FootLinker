import 'package:app/model/match.dart';
import 'package:flutter/material.dart';

class HistoryState extends ChangeNotifier {
  var history = <Match>[];

  bool toggleMatch(Match match) {
    if (history.contains(match)) {
      history.remove(match);
      notifyListeners();
      return false;
    }

    history.add(match);
    history.sort(
      (b, a) => a.timestamp.compareTo(b.timestamp),
    );
    notifyListeners();
    return true;
  }
}
