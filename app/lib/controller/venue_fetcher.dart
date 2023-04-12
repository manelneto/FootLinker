import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_management.dart';
import '../model/venue.dart';

class VenueFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Venue>> fetchVenues(String country) async {
    final response = await http.get(
      Uri.parse('${apiManagement.url}venues?country=$country'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> venuesList = body['response'];
      List<Venue> venues =
          venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
      return venues;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Venue> fetchVenue(int id) async {
    final response = await http.get(
      Uri.parse('${apiManagement.url}venues?id=$id'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> venuesList = body['response'];
      List<Venue> venues =
          venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
      return venues[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
