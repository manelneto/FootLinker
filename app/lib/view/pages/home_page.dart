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

  void _navigateToCreditsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreditsPage(),
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
          body: Center(
            child: page,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Principal',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_soccer,
                ),
                label: 'Clubes',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.stadium,
                ),
                label: 'Estádios',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.emoji_events,
                ),
                label: 'Ligas',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                ),
                label: 'Por Perto',
              ),
            ],
            iconSize: 30,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _navigateToCreditsPage(context),
            child: const Icon(Icons.logo_dev),
          ),
        );
      },
    );
  }
}
