import 'package:app/states/history_state.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var historyState = context.watch<HistoryState>();

    if (historyState.history.isEmpty) {
      return Scaffold(
        key: const Key('historyPage'),
        appBar: AppBar(
          title: const Text(
            'Histórico',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Ainda não adicionou nenhum jogo ao histórico...\nExperimente manter premido num jogo para o adicionar/remover!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        key: const Key('historyPage'),
        title: const Text(
          'Histórico',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            for (var match in historyState.history) MatchListTile(match: match),
          ],
        ),
      ),
    );
  }
}
