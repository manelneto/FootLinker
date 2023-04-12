import 'package:app/view/pages/matches_page.dart';
import 'package:location/location.dart';
import 'friends_page.dart';
import 'history_page.dart';
import 'leagues_page.dart';
import 'credits.dart';
import 'start_page.dart';
import 'teams_page.dart';
import 'venues_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _userLocation;
  bool locationSet = false;

  Future<void> _getUserLocation() async {
    Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();

    setState(
      () {
        _userLocation = locationData;
        locationSet = true;
      },
    );
  }

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
        if (locationSet) {
          page = MatchesPage(locationData: _userLocation);
        } else {
          page = const StartPage();
        }
        break;
      case 5:
        page = const FriendsPage();
        break;
      case 6:
        page = const Credits();
        break;
      case 7:
        page = const HistoryPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
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
                    NavigationRailDestination(
                      icon: Icon(Icons.logo_dev),
                      label: Text('Histórico'),
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
            onPressed: _getUserLocation,
            tooltip: 'Location',
            backgroundColor: Colors.white,
            child: const Icon(Icons.location_on),
          ),
        );
      },
    );
  }
}
