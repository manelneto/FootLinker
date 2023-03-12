import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';

class TeamsPage extends StatefulWidget {
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
    return Center(
      child: FutureBuilder<Team>(
        future: futureTeam,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
