import 'package:app/view/widgets/league_widget.dart';
import 'package:flutter/material.dart';
import '../../model/league.dart';
import '../../controller/league_fetcher.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  List<int> ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  List<Future<League>> leagues = [];
  late Future<League> league;

  @override
  void initState() {
    super.initState();
    for (var id in ids) {
      leagues.add(LeagueFetcher().fetchLeague(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Ligas')),
        for (var league in leagues)
          ListTile(
              leading: const Icon(Icons.emoji_events),
              title: ElevatedButton(
                onPressed: () {const LeaguesPage();},
                child: FutureBuilder<League>(
                future: league,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return LeagueWidget(league: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ))),
      ],
    );
  }
}
