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
  late Future<League> futureLeague;

  @override
  void initState() {
    super.initState();
    futureLeague = LeagueFetcher().fetchLeague();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Liga para Teste')),
        FutureBuilder<League>(
          future: futureLeague,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LeagueWidget(league: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
