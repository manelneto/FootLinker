import 'package:app/states/followed_state.dart';
import 'package:app/view/widgets/team_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowedPage extends StatelessWidget {
  const FollowedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var followedState = context.watch<FollowedState>();

    if (followedState.followed.isEmpty) {
      return Scaffold(
        key: const Key('followedPage'),
        appBar: AppBar(
          title: const Text(
            'Favoritos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Ainda não tem nenhuma equipa favorita...\nExperimente procurar uma equipa e adicioná-la aos favoritos!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: const Key('followedPage'),
      appBar: AppBar(
        title: const Text(
          'Favoritos',
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
            for (var team in followedState.followed) TeamListTile(team: team),
          ],
        ),
      ),
    );
  }
}
