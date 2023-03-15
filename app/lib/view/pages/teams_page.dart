import 'package:app/view/widgets/team_widget.dart';
import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  late Future<Team> futureTeam;

  @override
  void initState() {
    super.initState();
    futureTeam = TeamFetcher().fetchTeam();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Clube Favorito')),
        FutureBuilder<Team>(
            future: futureTeam,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TeamWidget(team: snapshot.data!);
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
