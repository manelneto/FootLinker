import 'package:app/controller/venue_fetcher.dart';
import 'package:app/model/venue.dart';
import 'package:app/view/widgets/venue_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class VenuesPage extends StatefulWidget {
  const VenuesPage({
    super.key,
  });

  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  late List<Venue> data;

  Widget _venues(data) {
    if (data.length > 0) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return VenueListTile(
            venue: data[index],
          );
        },
      );
    }
    return const Center(
      child: Text(
        'Não há estádios para apresentar...',
        textAlign: TextAlign.center,
      ),
    );
  }

  FutureBuilder _venuesData() {
    return FutureBuilder<List<Venue>>(
      future: VenueFetcher().fetchVenuesByCountry('portugal', IOClient()),
      builder: (BuildContext context, AsyncSnapshot<List<Venue>> snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data!;
          return _venues(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('venuesPage'),
      appBar: AppBar(
        title: const Text(
          'Estádios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Center(
        child: _venuesData(),
      ),
    );
  }
}
