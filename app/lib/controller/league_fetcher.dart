import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/league.dart';

class LeagueFetcher {
  Future<League> fetchLeague(int id) async {
    final response = await http.get(
        Uri.parse("https://v3.football.api-sports.io/leagues?id=$id"), //hardcoded for now
        headers: {
          'x-rapidapi-key': '28e2bd7ea34da73c2eb4e946fe77c052',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      return League.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
