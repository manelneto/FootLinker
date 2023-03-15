import 'package:flutter/material.dart';

import '../../model/team.dart';

class TeamWidget extends StatelessWidget {
  const TeamWidget({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sports_soccer),
      title: Text('${team.name} (${team.code}) - ${team.country}'),
    );
  }
}
