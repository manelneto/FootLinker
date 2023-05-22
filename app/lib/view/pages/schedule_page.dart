import 'package:app/states/schedule_state.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var scheduleState = context.watch<ScheduleState>();

    if (scheduleState.schedule.isEmpty) {
      return Scaffold(
        key: const Key('schedulePage'),
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
            'Ainda não adicionou nenhum jogo ao calendário...\nExperimente manter premido num jogo para o adicionar/remover!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: const Key('schedulePage'),
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
            for (var match in scheduleState.schedule)
              MatchListTile(match: match),
          ],
        ),
      ),
    );
  }
}
