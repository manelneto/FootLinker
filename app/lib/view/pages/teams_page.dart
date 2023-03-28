import 'package:app/view/widgets/team_list_tile.dart';
import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  ListView _teams(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return TeamListTile(
            team: data[index],
          );
        },
      );
    } else {
      return ListView(
        children: const [
          Center(
            child: Text(
              'Não há equipas para apresentar...',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
  }

  FutureBuilder _teamsData() {
    return FutureBuilder<List<Team>>(
      future: TeamFetcher().fetchTeams('portugal'),
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
      appBar: AppBar(
        title: const Center(child: Text('Equipas')),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: _teamsData(),
      ),
    );
  }
}
