import 'package:flutter/material.dart';

import '../../model/team.dart';

class TeamListTile extends StatelessWidget {
  const TeamListTile({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        team.logo,
        loadingBuilder: (context, child, progress) {
          return progress == null ? child : const LinearProgressIndicator();
        },
        fit: BoxFit.contain,
        semanticLabel: 'Team Logo',
      ),
      title: Center(child: Text(team.name)),
      subtitle: Center(child: Text(team.code)),
    );
  }
}
