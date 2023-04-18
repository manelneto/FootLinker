import 'package:app/app_state.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    if (appState.schedule.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calendário',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Ainda não adicionou nenhum jogo ao calendário...\nExperimente carregar num jogo para o adicionar ou manter premido para o remover.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendário',
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
            for (var match in appState.schedule) MatchListTile(match: match),
          ],
        ),
      ),
    );
  }
}
