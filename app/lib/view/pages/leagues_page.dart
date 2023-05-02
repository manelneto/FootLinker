import 'package:app/controller/league_fetcher.dart';
import 'package:app/model/league.dart';
import 'package:app/view/widgets/league_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({
    super.key,
  });

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  Widget _leagues(data) {
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
    return const Center(
      child: Text(
        'Não há ligas para apresentar...',
        textAlign: TextAlign.center,
      ),
    );
  }

  FutureBuilder _leaguesData() {
    return FutureBuilder<List<League>>(
      future: LeagueFetcher().fetchLeaguesByCountry('portugal', IOClient()),
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
      key: const Key('leaguesPage'),
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
