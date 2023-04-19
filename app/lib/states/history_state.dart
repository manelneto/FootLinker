import 'package:flutter/material.dart';
import 'package:app/model/match.dart';

class HistoryState extends ChangeNotifier {
  var history = <Match>[];

  void addMatch(Match match, BuildContext context) {
    if (!history.contains(match)) {
      history.add(match);
      history.sort(
            (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      notifyListeners();
      var snackBar = SnackBar(
        content: Center(
          child: Text(
            '${match.home.name} - ${match.away.name} adicionado ao histórico!',
          ),
        ),
        action: SnackBarAction(
          label: 'Anular',
          onPressed: () {
            if (history.remove(match)) {
              notifyListeners();
            }
          },
        ),
        duration: const Duration(
          seconds: 1,
        ),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  void removeMatch(Match match, BuildContext context) {
    if (history.remove(match)) {
      notifyListeners();
      var snackBar = SnackBar(
        content: Center(
          child: Text(
            '${match.home.name} - ${match.away.name} removido do histórico!',
          ),
        ),
        action: SnackBarAction(
          label: 'Anular',
          onPressed: () {
            if (!history.contains(match)) {
              history.add(match);
              history.sort(
                    (a, b) => a.timestamp.compareTo(b.timestamp),
              );
              notifyListeners();
            }
          },
        ),
        duration: const Duration(
          seconds: 1,
        ),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
