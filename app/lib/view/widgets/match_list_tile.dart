import 'package:app/model/match.dart';
import 'package:app/states/history_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool toggle = true;

class MatchListTile extends StatelessWidget {
  const MatchListTile({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    var historyState = context.watch<HistoryState>();
    var scheduleState = context.watch<ScheduleState>();

    String title = '${match.home.name} - ${match.away.name}';
    if (match.homeGoals != -1 && match.awayGoals != -1) {
      title += '\n${match.homeGoals} - ${match.awayGoals}';
    }

    String subtitle = match.date.length >= 16
        ? '${match.venue.name}\n${match.date.substring(8, 10)}/${match.date.substring(5, 7)} - ${match.date.substring(11, 16)}'
        : '';

    return ListTile(
      key: const Key('matchListTile'),
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 60,
          maxWidth: 60,
          minWidth: 60,
        ),
        child: Image.network(
          match.home.logo,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const LinearProgressIndicator();
          },
          fit: BoxFit.contain,
          semanticLabel: 'Home Team Logo',
        ),
      ),
      title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      isThreeLine: true,
      subtitle: Center(
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
        ),
      ),
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 60,
          maxWidth: 60,
          minWidth: 60,
        ),
        child: Image.network(
          match.away.logo,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const LinearProgressIndicator();
          },
          fit: BoxFit.contain,
          semanticLabel: 'Away Team Logo',
        ),
      ),
      onTap: () {
        if (toggle) {
          if (match.homeGoals != -1 && match.awayGoals != -1) {
            historyState.addMatch(match);
            showSnackBar(
              match,
              'adicionado ao histórico',
              historyState.removeMatch,
              context,
            );
          } else if (match.homeGoals == -1 && match.awayGoals == -1) {
            scheduleState.addMatch(match);
            showSnackBar(
              match,
              'adicionado ao calendário',
              scheduleState.removeMatch,
              context,
            );
          }
        } else {
          if (match.homeGoals != -1 && match.awayGoals != -1) {
            historyState.removeMatch(match);
            showSnackBar(
              match,
              'removido do histórico',
              historyState.addMatch,
              context,
            );
          } else if (match.homeGoals == -1 && match.awayGoals == -1) {
            scheduleState.removeMatch(match);
            showSnackBar(
              match,
              'removido do calendário',
              scheduleState.addMatch,
              context,
            );
          }
        }
      },
    );
  }

  void showSnackBar(
    Match match,
    String text,
    void Function(Match) function,
    BuildContext context,
  ) {
    var snackBar = SnackBar(
      content: Center(
        child: Text(
          '${match.home.name} - ${match.away.name} $text!',
        ),
      ),
      action: SnackBarAction(
        label: 'Anular',
        onPressed: () => function(match),
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
