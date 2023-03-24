import 'package:flutter/material.dart';

import '../../model/league.dart';

class LeagueWidget extends StatelessWidget {
  const LeagueWidget({
    super.key,
    required this.league,
  });

  final League league;

  @override
  Widget build(BuildContext context) {
      return Text(league.name);
  }
}
