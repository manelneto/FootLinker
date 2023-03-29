import 'package:app/view/widgets/league_list_tile.dart';
import 'package:flutter/material.dart';
import '../../model/league.dart';
import '../../controller/league_fetcher.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  ListView _leagues(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return LeagueListTile(
            league: data[index],
          );
        },
      );
    }
    return ListView(
      children: const [
        Center(
          child: Text(
            'Não há ligas para apresentar...',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  FutureBuilder _leaguesData() {
    return FutureBuilder<List<League>>(
      future: LeagueFetcher().fetchLeagues('portugal'),
      builder: (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
        if (snapshot.hasData) {
          List<League> data = snapshot.data!;
          return _leagues(data);
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
        title: const Text(
          'Ligas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: _leaguesData(),
      ),
    );
  }
}
