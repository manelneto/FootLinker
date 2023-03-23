import 'package:app/model/venue.dart';
import 'package:app/view/widgets/venue_widget.dart';
import 'package:flutter/material.dart';
import '../../controller/venue_fetcher.dart';

class VenuesPage extends StatefulWidget {
  const VenuesPage({super.key});

  @override
  State<VenuesPage> createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  late Future<Venue> futureVenue;

  @override
  void initState() {
    super.initState();
    futureVenue = VenueFetcher().fetchVenue();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(child: Text('Estádio Pesquisado:')),
        FutureBuilder<Venue>(
            future: futureVenue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return VenueWidget(venue: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
        ),
      ],
    );
  }
}
