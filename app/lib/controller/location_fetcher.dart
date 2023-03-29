import 'package:geocoding/geocoding.dart';

class LocationFetcher {
  Future<Location> fetchCoordinates(String address) async {
    List<Location> locations = await locationFromAddress(address);
    var first = locations.first;
    return first;
  }
}
