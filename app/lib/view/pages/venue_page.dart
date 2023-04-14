import 'package:app/model/venue.dart';
import 'package:app/view/widgets/map_widget.dart';
import 'package:flutter/material.dart';

import 'package:app/controller/location_fetcher.dart';

class VenuePage extends StatefulWidget {
  const VenuePage({
    super.key,
    required this.venue,
  });

  final Venue venue;

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  FutureBuilder _locationData() {
    return FutureBuilder(
      future: LocationFetcher().fetchCoordinates(widget.venue.name),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return MapWidget(
            location: data,
            venue: widget.venue,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const LinearProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String text;
    if (widget.venue.address == '' && widget.venue.city == '') {
      text = 'Morada não encontrada';
    } else if (widget.venue.address == '') {
      text = widget.venue.city;
    } else if (widget.venue.city == '') {
      text = widget.venue.address;
    } else {
      text = "${widget.venue.address}, ${widget.venue.city}";
    }
    if (widget.venue.capacity != 0) {
      text += "\nCapacidade: ${widget.venue.capacity}";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Estádio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                widget.venue.name.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.venue.image),
              radius: 100.0,
            ),
            const SizedBox(
              height: 25.0,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
              height: 350.0,
              child: _locationData(),
            ),
          ],
        ),
      ),
    );
  }
}
