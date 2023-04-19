import 'package:flutter/material.dart';
import 'package:app/model/match.dart';

class ScheduleState extends ChangeNotifier {
  var schedule = <Match>[];

  void addMatch(Match match, BuildContext context) {
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

  void removeMatch(Match match, BuildContext context) {
    if (schedule.remove(match)) {
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
}
