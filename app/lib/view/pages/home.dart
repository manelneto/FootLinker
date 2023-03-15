import 'package:app/view/pages/map_page.dart';
import 'package:app/view/pages/start_page.dart';
import 'package:app/view/pages/teams_page.dart';
import 'package:app/view/pages/venues_page.dart';
import 'package:flutter/material.dart';

import 'friends_page.dart';
import 'our_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
        page = StartPage();
        break;
      case 1:
        page = TeamsPage();
        break;
      case 2:
        page = VenuesPage();
        break;
      case 3:
        page = MapPage();
        break;
      case 4:
        page = FriendsPage();
        break;
      case 5:
        page = OurPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(icon: Icon(Icons.home), label: Text('Página Principal')),
                  NavigationRailDestination(icon: Icon(Icons.sports_soccer), label: Text('Clubes')),
                  NavigationRailDestination(icon: Icon(Icons.stadium), label: Text('Estádios')),
                  NavigationRailDestination(icon: Icon(Icons.map), label: Text('Mapa')),
                  NavigationRailDestination(icon: Icon(Icons.people), label: Text('Amigos')),
                  NavigationRailDestination(icon: Icon(Icons.logo_dev), label: Text('Sobre Nós')),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {selectedIndex = value;});
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
      );
    });
  }
}