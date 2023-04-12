import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../widgets/match_list_tile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.history.isEmpty) {
      return const Center(
        child: Text(
            'Ainda não adicionou nenhum jogo ao histórico.\nExperimente ...!'),
      );
    }

    return ListView(
      children: [
        for (var match in appState.history) MatchListTile(match: match),
      ],
    );
  }
}
