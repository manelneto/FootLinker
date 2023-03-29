import 'package:flutter/material.dart';

import '../../model/league.dart';
import '../pages/league_page.dart';

class LeagueListTile extends StatelessWidget {
  const LeagueListTile({
    super.key,
    required this.league,
  });

  final League league;

  void _navigateToMatchesPage(BuildContext context, League league) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LeaguePage(league: league)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 50,
          minHeight: 15,
          maxWidth: 50,
          minWidth: 25,
        ),
        child: Image.network(
          league.logo,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const LinearProgressIndicator();
          },
          fit: BoxFit.fitHeight,
          semanticLabel: 'League Logo',
        ),
      ),
      title: Center(
        child: Text(
          league.name,
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Center(
        child: Text(
          league.country,
          textAlign: TextAlign.center,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        _navigateToMatchesPage(context, league);
      },
    );
  }
}
