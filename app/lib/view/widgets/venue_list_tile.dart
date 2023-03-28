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
      leading: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 75,
          minHeight: 75,
          maxWidth: 75,
          minWidth: 75,
        ),
        child: Image.network(
          venue.image,
          loadingBuilder: (context, child, progress) {
            return progress == null ? child : const LinearProgressIndicator();
          },
          fit: BoxFit.contain,
          semanticLabel: 'Venue Image',
        ),
      ),
      title: Center(child: Text(venue.name, textAlign: TextAlign.center,),),
      subtitle: Center(child: Text(venue.city, textAlign: TextAlign.center,),),
    );
  }
}
