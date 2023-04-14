import 'package:app/api_management.dart';
import 'package:app/controller/location_fetcher.dart';
import 'package:app/model/match.dart';
import 'package:app/model/venue.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import 'venue_fetcher.dart';

class MatchFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Match>> fetchNextMatchesByLocation(
      LocationData locationData, int next) async {
    List<Venue> venues = await VenueFetcher().fetchVenuesByCountry('portugal');

    Venue closestVenue = Venue(id: 0, name: 'name', city: 'city');
    double minDistance = double.maxFinite;
    LocationFetcher locationFetcher = LocationFetcher();

    for (Venue venue in venues) {
      if (venue.capacity > 5000) {
        try {
          var location = await locationFetcher.fetchCoordinates(venue.name);
          double distance = locationFetcher.calculateDistance(
              locationData.latitude,
              locationData.longitude,
              location.latitude,
              location.longitude);
          if (distance < minDistance) {
            closestVenue = venue;
            minDistance = distance;
          }
        } on NoResultFoundException {
          // empty for now
        }
      }
    }

    List<Match> matches;
    try {
      List<dynamic> matchesList = await apiManagement
          .sendRequest('fixtures?venue=${closestVenue.id}&next=$next');
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    return matches;
  }

  Future<List<Match>> fetchNextMatchesByLeague(int league, int next) async {
    List<Match> matches;
    try {
      List<dynamic> matchesList =
          await apiManagement.sendRequest('fixtures?league=$league&next=$next');
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    return matches;
  }
}
