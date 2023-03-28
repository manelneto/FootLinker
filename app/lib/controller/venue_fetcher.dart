import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/venue.dart';

class VenueFetcher {
  Future<List<Venue>> fetchVenues(String country) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/venues?country=$country'),
        headers: {
          'x-rapidapi-key': 'XXX',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> venuesList = body['response'];
      List<Venue> venues = venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
      return venues;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Venue> fetchVenue(int id) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/venues?id=$id'),
        headers: {
          'x-rapidapi-key': 'XXX',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> venuesList = body['response'];
      List<Venue> venues = venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
      return venues[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
