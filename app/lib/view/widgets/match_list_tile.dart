import 'package:app/model/match.dart';
import 'package:app/states/history_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      tileColor: historyState.history.contains(match) ||
              scheduleState.schedule.contains(match)
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
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
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
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
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
      onLongPress: () {
        if (match.homeGoals != -1 && match.awayGoals != -1) {
          if (historyState.toggleMatch(
              match,
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid))) {
            showSnackBar(
              match,
              'adicionado ao histórico',
              historyState.toggleMatch,
              context,
            );
          } else {
            showSnackBar(
              match,
              'removido do histórico',
              historyState.toggleMatch,
              context,
            );
          }
        } else if (match.homeGoals == -1 && match.awayGoals == -1) {
          if (scheduleState.toggleMatch(
              match,
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid))) {
            showSnackBar(
              match,
              'adicionado ao calendário',
              scheduleState.toggleMatch,
              context,
            );
          } else {
            showSnackBar(
              match,
              'removido do calendário',
              scheduleState.toggleMatch,
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
    void Function(Match, DocumentReference<Map<String, dynamic>>) function,
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
        onPressed: () => function(
            match,
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)),
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
