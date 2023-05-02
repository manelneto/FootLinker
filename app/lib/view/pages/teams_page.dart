import 'package:app/controller/team_fetcher.dart';
import 'package:app/model/team.dart';
import 'package:app/view/widgets/team_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({
    super.key,
  });

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  Widget _teams(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return TeamListTile(
            team: data[index],
          );
        },
      );
    }
    return const Center(
      child: Text(
        'Não há equipas para apresentar...',
        textAlign: TextAlign.center,
      ),
    );
  }

  FutureBuilder _teamsData() {
    return FutureBuilder<List<Team>>(
      future: TeamFetcher().fetchTeamsByCountry('portugal', IOClient()),
      builder: (BuildContext context, AsyncSnapshot<List<Team>> snapshot) {
        if (snapshot.hasData) {
          List<Team> data = snapshot.data!;
          return _teams(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('teamsPage'),
      appBar: AppBar(
        title: const Text(
          'Equipas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: _teamsData(),
      ),
    );
  }
}
