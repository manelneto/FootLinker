import 'package:flutter/material.dart';

import '../../model/venue.dart';

class VenueWidget extends StatelessWidget {
  const VenueWidget({
    super.key,
    required this.venue,
  });

  final Venue venue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.stadium),
      title: Text('${venue.name} - ${venue.city}'),
    );
  }
}
