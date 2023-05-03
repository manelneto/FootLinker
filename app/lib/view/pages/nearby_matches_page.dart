import 'package:app/controller/match_fetcher.dart';
import 'package:app/model/match.dart';
import 'package:app/view/widgets/match_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:location/location.dart';

class NearbyMatchesPage extends StatefulWidget {
  const NearbyMatchesPage({
    super.key,
  });

  @override
  State<NearbyMatchesPage> createState() => _NearbyMatchesPageState();
}

class _NearbyMatchesPageState extends State<NearbyMatchesPage> {
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

  Widget _matches(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
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
      future: MatchFetcher()
          .fetchNextMatchesByLocation(_userLocation, 9, IOClient()),
      builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
        if (snapshot.hasData) {
          List<Match> data = snapshot.data!;
          return _matches(data);
        } else if (snapshot.hasError) {
          return const Text(
            'Ocorreu um erro de rede.\nTente fechar e voltar a abrir a página.',
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!locationSet) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Jogos Perto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            height: 75,
            width: 300,
            child: ElevatedButton.icon(
              onPressed: () => _getUserLocation(),
              icon: const Icon(
                Icons.location_on,
                size: 40,
              ),
              label: const Text(
                'Ativar Localização',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: const Key('nearbyMatchesPage'),
      appBar: AppBar(
        title: const Text(
          'Jogos Perto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: _matchesData(),
      ),
    );
  }
}
