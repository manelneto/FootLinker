import 'dart:convert';
import 'dart:math';

import 'package:app/controller/location_fetcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../api_management.dart';
import '../model/match.dart';
import '../model/venue.dart';
import 'venue_fetcher.dart';

class MatchFetcher {
  ApiManagement apiManagement = ApiManagement();

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<List<Match>> fetchMatchesByLocation(LocationData locationData, int number) async {
    List<Venue> venues = await VenueFetcher().fetchVenues('portugal');

    Venue closestVenue = Venue(id: 0, name: 'name', city: 'city');
    double minDistance = double.maxFinite;
    LocationFetcher locationFetcher = LocationFetcher();

    for (Venue venue in venues) {
      if (venue.capacity < 5000) {
        continue;
      }
      var location;
      try {
        location = await locationFetcher.fetchCoordinates(venue.name);
        double distance = calculateDistance(locationData.latitude, locationData.longitude, location.latitude, location.longitude);
        if (distance < minDistance) {
          closestVenue = venue;
          minDistance = distance;
        }
      } on NoResultFoundException {
        // empty for now
      }
    }

    final response = await http.get(
      Uri.parse('${apiManagement.url}fixtures?venue=${closestVenue.id}&next=$number'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> matchesList = body['response'];
      List<Match> matches = matchesList.map((dynamic item) => Match.fromJson(item)).toList();
      return matches;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Match>> fetchMatchesByLeague(int league, int number) async {
    final response = await http.get(
        Uri.parse('${apiManagement.url}fixtures?league=$league&next=$number'),
        headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> matchesList = body['response'];
      List<Match> matches = matchesList.map((dynamic item) => Match.fromJson(item)).toList();
      return matches;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Match> fetchMatch(int id) async {
    final response = await http.get(
        Uri.parse('${apiManagement.url}fixtures?id=$id'),
        headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> matchesList = body['response'];
      List<Match> matches = matchesList.map((dynamic item) => Match.fromJson(item)).toList();
      return matches[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
