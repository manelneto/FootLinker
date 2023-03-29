import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/venue.dart';

class VenueFetcher {
  Future<List<Venue>> fetchVenues(String country) async {
    final response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/venues?country=$country'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/venues?id=$id'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
