import 'package:app/model/league.dart';
import 'package:app/view/pages/league_page.dart';
import 'package:flutter/material.dart';

class LeagueListTile extends StatelessWidget {
  const LeagueListTile({
    super.key,
    required this.league,
  });

  final League league;

  void _navigateToLeaguePage(BuildContext context, League league) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LeaguePage(league: league),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const Key('leagueListTile'),
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
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
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
      trailing: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.arrow_forward_ios),
      ),
      onTap: () {
        _navigateToLeaguePage(context, league);
      },
    );
  }
}
