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
  List<int> ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
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
    return Scaffold(
      body: GridView.count(crossAxisCount: 2, children: [
        for (var league in leagues)
          InkWell(
              splashColor: Colors.black,
              onTap: () {
                const LeaguesPage(); //o que o botão faz
              },
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Ink.image(
                    image: const NetworkImage(''),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover),
                const SizedBox(height: 3),
                FutureBuilder<League>(
                  future: league,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LeagueWidget(league: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 6),
              ]))
      ]),
    );
  }
}

/*
ElevatedButton(
                onPressed: () {
                  const LeaguesPage();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
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
                )),*/