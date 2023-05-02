import 'package:app/view/pages/credits_page.dart';
import 'package:app/view/pages/home_page.dart';
import 'package:app/view/pages/leagues_page.dart';
import 'package:app/view/pages/nearby_matches_page.dart';
import 'package:app/view/pages/teams_page.dart';
import 'package:app/view/pages/venues_page.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
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
        page = HomePage(navigatorKey: widget.navigatorKey);
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
      default:
        throw UnimplementedError('Índice inválido: $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: const Key('appPage'),
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
