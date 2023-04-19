import 'package:app/view/pages/credits_page.dart';
import 'package:app/view/pages/history_page.dart';
import 'package:app/view/pages/leagues_page.dart';
import 'package:app/view/pages/nearby_matches_page.dart';
import 'package:app/view/pages/profile_page.dart';
import 'package:app/view/pages/schedule_page.dart';
import 'package:app/view/pages/teams_page.dart';
import 'package:app/view/pages/venues_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToHistoryPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryPage(),
      ),
    );
  }

  void _navigateToSchedulePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SchedulePage(),
      ),
    );
  }

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ProfilePage(
          navigatorKey: widget.navigatorKey,
        );
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
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                      label: Text('Página Principal'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                      ),
                      label: Text('Clubes'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.stadium,
                        size: 25,
                      ),
                      label: Text('Estádios'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.emoji_events,
                        size: 25,
                      ),
                      label: Text('Ligas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.map,
                        size: 25,
                      ),
                      label: Text('Jogos Perto'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.logo_dev,
                        size: 25,
                      ),
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
          floatingActionButton: Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                key: const Key('history'),
                heroTag: 'history',
                onPressed: () => _navigateToHistoryPage(context),
                tooltip: 'History Page',
                backgroundColor: Colors.white,
                child: const Icon(Icons.history),
              ),
              const SizedBox(width: 5),
              FloatingActionButton(
                key: const Key('schedule'),
                heroTag: 'schedule',
                onPressed: () => _navigateToSchedulePage(context),
                tooltip: 'Schedule Page',
                backgroundColor: Colors.white,
                child: const Icon(Icons.date_range),
              )
            ],
          ),
        );
      },
    );
  }
}
