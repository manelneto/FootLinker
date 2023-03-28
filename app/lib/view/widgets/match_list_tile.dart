import 'package:flutter/material.dart';

import '../../model/match.dart';

class MatchListTile extends StatelessWidget {
  const MatchListTile({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        match.home.logo,
        loadingBuilder: (context, child, progress) {
          return progress == null ? child : const LinearProgressIndicator();
        },
        fit: BoxFit.contain,
        semanticLabel: 'Home Team Logo',
      ),
      title: Center(child: Text('${match.home.name} - ${match.away.name}')),
      subtitle: Center(child: Text(match.venue.name)),
      trailing: Image.network(
        match.away.logo,
        loadingBuilder: (context, child, progress) {
          return progress == null ? child : const LinearProgressIndicator();
        },
        fit: BoxFit.contain,
        semanticLabel: 'Away Team Logo',
      ),
    );
  }
}
