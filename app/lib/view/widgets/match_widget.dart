import 'package:flutter/material.dart';

import '../../model/match.dart';

class MatchWidget extends StatelessWidget {
  const MatchWidget({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sports_soccer),
      title: Text('${match.home.name} - ${match.away.name}\n${match.score}'),
    );
  }
}
