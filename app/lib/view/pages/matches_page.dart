import 'package:app/view/widgets/match_widget.dart';
import 'package:flutter/material.dart';
import '../../model/match.dart';
import '../../controller/match_fetcher.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  late Future<Match> futureMatch;

  @override
  void initState() {
    super.initState();
    futureMatch = MatchFetcher().fetchMatch();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Jogo para Teste')),
        FutureBuilder<Match>(
          future: futureMatch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MatchWidget(match: snapshot.data!);
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
