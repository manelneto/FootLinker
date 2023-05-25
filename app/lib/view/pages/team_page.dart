import 'package:app/controller/match_fetcher.dart';
import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/states/followed_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({
    super.key,
    required this.team,
  });

  final Team team;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var nextMatches = <Match>[];

  Widget _matches(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index].homeGoals == -1 && data[index].awayGoals == -1) {
            nextMatches.add(data[index]);
          }
          return MatchListTile(
            match: data[index],
          );
        },
      );
    }
    return const Center(
      child: Text(
        'Não há jogos para apresentar...',
        textAlign: TextAlign.center,
      ),
    );
  }

  FutureBuilder _matchesData() {
    return FutureBuilder<List<Match>>(
      future: MatchFetcher().fetchMatchesByTeam(widget.team.id, 5, IOClient()),
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (snapshot.hasData) {
          List<Match> data = snapshot.data!;
          return _matches(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const LinearProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var followedState = context.watch<FollowedState>();
    var scheduleState = context.watch<ScheduleState>();

    IconData icon;
    if (followedState.followed.contains(widget.team)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.team.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.network(
                widget.team.logo,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const LinearProgressIndicator();
                },
                fit: BoxFit.contain,
                semanticLabel: 'Team Logo',
                height: 100.0,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return const Icon(Icons.error);
                },
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => followedState.toggleTeam(
                  widget.team,
                  nextMatches,
                  scheduleState,
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid),
                ),
                icon: Icon(icon),
                label: const Text('Seguir'),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: _matchesData(),
          )
        ],
      ),
    );
  }
}
