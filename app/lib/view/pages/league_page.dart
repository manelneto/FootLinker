import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import '../../model/league.dart';
import '../../model/match.dart';
import '../../controller/match_fetcher.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({
    super.key,
    required this.league,
  });

  final League league;

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  ListView _matches(data) {
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
    return ListView(
      children: const [
        Center(
          child: Text(
            'Não há jogos para apresentar...',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  FutureBuilder _matchesData() {
    return FutureBuilder<List<Match>>(
      future: MatchFetcher().fetchMatchesByLeague(widget.league.id, 9),
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
          widget.league.name,
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