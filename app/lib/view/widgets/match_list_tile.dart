import 'package:app/main.dart';
import 'package:app/model/match.dart';
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
    var appState = context.watch<MyAppState>();

    String title = '${match.home.name} - ${match.away.name}';
    if (match.homeGoals != -1 && match.awayGoals != -1) {
      title += '\n${match.homeGoals} - ${match.awayGoals}';
    }

    String subtitle = '${match.venue.name}\n${match.date.substring(8, 10)}/${match.date.substring(5, 7)} - ${match.date.substring(11, 16)}';

    return ListTile(
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
        if (match.homeGoals != -1 && match.awayGoals != -1) {
          appState.toggleHistory(match);
        }
      },
    );
  }
}
