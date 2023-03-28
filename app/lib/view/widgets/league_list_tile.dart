import 'package:flutter/material.dart';

import '../../model/league.dart';
import '../pages/matches_page.dart';

class LeagueListTile extends StatelessWidget {
  const LeagueListTile({
    super.key,
    required this.league,
  });

  final League league;

  void _navigateToMatchesPage(BuildContext context, League league) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MatchesPage(league: league)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        league.logo,
        loadingBuilder: (context, child, progress) {
          return progress == null ? child : const LinearProgressIndicator();
        },
        fit: BoxFit.contain,
        semanticLabel: 'League Logo',
      ),
      title: Center(child: Text(league.name)),
      subtitle: Center(child: Text(league.country)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        _navigateToMatchesPage(context, league);
      },
    );
  }
}
