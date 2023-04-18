import 'package:app/model/match.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var history = <Match>[];
  var schedule = <Match>[];

  void addToHistory(Match match, BuildContext context) {
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

  void removeFromHistory(Match match, BuildContext context) {
    history.remove(match);
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

  void addToSchedule(Match match, BuildContext context) {
    if (!schedule.contains(match)) {
      schedule.add(match);
      schedule.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      notifyListeners();
      var snackBar = SnackBar(
        content: Center(
          child: Text(
            '${match.home.name} - ${match.away.name} adicionado ao calendário!',
          ),
        ),
        action: SnackBarAction(
          label: 'Anular',
          onPressed: () {
            if (schedule.remove(match)) {
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

  void removeFromSchedule(Match match, BuildContext context) {
    schedule.remove(match);
    notifyListeners();
    var snackBar = SnackBar(
      content: Center(
        child: Text(
          '${match.home.name} - ${match.away.name} removido do calendário!',
        ),
      ),
      action: SnackBarAction(
        label: 'Anular',
        onPressed: () {
          if (!schedule.contains(match)) {
            schedule.add(match);
            schedule.sort(
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
