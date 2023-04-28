import 'package:app/controller/match_fetcher.dart';
import 'package:app/model/team.dart';
import 'package:app/model/match.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  Widget _matches(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MatchListTile(
            match: data[index],
          );
        },
      );
    }
    return const Center(
      child: Text(
        'Não há jogos para apresentar...',
        textAlign: TextAlign.center,
      ),
    );
  }

  FutureBuilder _matchesData() {
    return FutureBuilder<List<Match>>(
      future:
      MatchFetcher().fetchMatchesByTeam(widget.team.id, 2, IOClient()),
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (snapshot.hasData) {
          List<Match> data = snapshot.data!;
          return _matches(data);
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
        title: Text(
          widget.team.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: _matchesData(),
      ),
    );
  }
}
