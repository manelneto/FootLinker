import 'package:app/model/venue.dart';
import 'package:app/view/widgets/venue_list_tile.dart';
import 'package:flutter/material.dart';
import '../../controller/venue_fetcher.dart';

class VenuesPage extends StatefulWidget {
  const VenuesPage({super.key});

  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  ListView _venues(data) {
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
    return ListView(
      children: const [
        Center(
          child: Text(
            'Não há estádios para apresentar...',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  FutureBuilder _venuesData() {
    return FutureBuilder<List<Venue>>(
      future: VenueFetcher().fetchVenues('portugal'),
      builder: (BuildContext context, AsyncSnapshot<List<Venue>> snapshot) {
        if (snapshot.hasData) {
          List<Venue> data = snapshot.data!;
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
      appBar: AppBar(
        title: const Center(child: Text('Estádios')),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: _venuesData(),
      ),
    );
  }
}
