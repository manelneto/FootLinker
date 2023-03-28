import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/league.dart';

class LeagueFetcher {
  Future<List<League>> fetchLeagues(String country) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/leagues?country=$country'),
        headers: {
          'x-rapidapi-key': '236387583694a852afa31bbc5eaa0014',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> leaguesList = body['response'];
      List<League> leagues = leaguesList.map((dynamic item) => League.fromJson(item)).toList();
      return leagues;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<League> fetchLeague(int id) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/leagues?id=$id'),
        headers: {
          'x-rapidapi-key': '236387583694a852afa31bbc5eaa0014',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> leaguesList = body['response'];
      List<League> leagues = leaguesList.map((dynamic item) => League.fromJson(item)).toList();
      return leagues[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
