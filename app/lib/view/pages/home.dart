import 'package:app/view/pages/nearby_matches_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:app/view/pages/credits_page.dart';
import 'package:app/view/pages/friends_page.dart';
import 'package:app/view/pages/history_page.dart';
import 'package:app/view/pages/leagues_page.dart';
import 'package:app/view/pages/start_page.dart';
import 'package:app/view/pages/teams_page.dart';
import 'package:app/view/pages/venues_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const StartPage();
        break;
      case 1:
        page = const TeamsPage();
        break;
      case 2:
        page = const VenuesPage();
        break;
      case 3:
        page = const LeaguesPage();
        break;
      case 4:
        page = const NearbyMatchesPage();
        break;
      case 5:
        page = const FriendsPage();
        break;
      case 6:
        page = const CreditsPage();
        break;
      default:
        throw UnimplementedError('Índice inválido: $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Página Principal'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.sports_soccer),
                      label: Text('Clubes'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.stadium),
                      label: Text('Estádios'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.emoji_events),
                      label: Text('Ligas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.map),
                      label: Text('Jogos Perto'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      label: Text('Amigos'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.logo_dev),
                      label: Text('Créditos'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'DEV',
            backgroundColor: Colors.white,
            child: const Icon(Icons.logo_dev),
          ),
        );
      },
    );
  }
}
