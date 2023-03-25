import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/venue.dart';

class VenueFetcher {
  Future<Venue> fetchVenue() async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/venues?id=556'), // Old Trafford
        headers: {
          'x-rapidapi-key': '28e2bd7ea34da73c2eb4e946fe77c052',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      return Venue.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
