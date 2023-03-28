import 'package:flutter/material.dart';

import '../../model/venue.dart';

class VenueListTile extends StatelessWidget {
  const VenueListTile({
    super.key,
    required this.venue,
  });

  final Venue venue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        venue.image,
        loadingBuilder: (context, child, progress) {
          return progress == null ? child : const LinearProgressIndicator();
        },
        fit: BoxFit.contain,
        semanticLabel: 'Venue Image',
      ),
      title: Center(child: Text(venue.name)),
      subtitle: Center(child: Text(venue.city)),
    );
  }
}
