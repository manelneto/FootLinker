import 'package:app/model/venue.dart';
import 'package:app/view/pages/venue_page.dart';
import 'package:flutter/material.dart';

class VenueListTile extends StatelessWidget {
  const VenueListTile({
    super.key,
    required this.venue,
  });

  final Venue venue;

  void _navigateToVenuePage(BuildContext context, Venue venue) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenuePage(venue: venue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const Key('teamListTile'),
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
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
      title: Center(
        child: Text(
          venue.name,
          textAlign: TextAlign.center,
        ),
      ),
      subtitle: Center(
        child: Text(
          venue.city,
          textAlign: TextAlign.center,
        ),
      ),
      trailing: const SizedBox(
        height: double.infinity,
        child: Icon(Icons.arrow_forward_ios),
      ),
      onTap: () {
        _navigateToVenuePage(context, venue);
      },
    );
  }
}
