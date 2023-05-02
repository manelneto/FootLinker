import 'package:app/model/venue.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.venue,
    required this.location,
  });

  final Venue venue;
  final Location location;

  @override
  State<MapWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      Marker(
        markerId: MarkerId(widget.venue.name),
        position: LatLng(
          widget.location.latitude,
          widget.location.longitude,
        ),
        infoWindow:
            InfoWindow(title: widget.venue.name, snippet: widget.venue.address),
      ),
    };

    return GoogleMap(
      key: const Key('map'),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.latitude, widget.location.longitude),
        zoom: 16.0,
      ),
      markers: markers,
    );
  }
}
