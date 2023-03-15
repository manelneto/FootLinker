import 'package:app/view/widgets/venue_widget.dart';
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
    return ListView(
      children: [
        const Center(child: Text('Estádio Favorito')),
        FutureBuilder<Team>(
            future: futureTeam,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return VenueWidget(venue: snapshot.data!.venue);
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
