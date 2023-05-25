import 'package:app/model/team.dart';
import 'package:app/view/pages/team_page.dart';
import 'package:flutter/material.dart';

class TeamListTile extends StatelessWidget {
  const TeamListTile({
    super.key,
    required this.team,
  });

  final Team team;

  void _navigateToTeamPage(BuildContext context, Team team) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TeamPage(team: team),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const Key('teamListTile'),
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 60,
          maxWidth: 60,
          minWidth: 60,
        ),
        child: Image.network(
          team.logo,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const LinearProgressIndicator();
          },
          fit: BoxFit.contain,
          semanticLabel: 'Team Logo',
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
      title: Center(
        child: Text(
          team.name,
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Center(
        child: Text(
          team.code,
          textAlign: TextAlign.center,
        ),
      ),
      trailing: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.arrow_forward_ios),
      ),
      onTap: () {
        _navigateToTeamPage(context, team);
      },
    );
  }
}
