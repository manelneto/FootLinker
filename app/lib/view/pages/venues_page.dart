import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/team.dart';
import '../../controller/team_fetcher.dart';

class VenuesPage extends StatefulWidget {
  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
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
              return Text(snapshot.data!.venue.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
      ),
    );
  }
}
