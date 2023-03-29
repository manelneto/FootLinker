import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/league.dart';

class LeagueFetcher {
  Future<List<League>> fetchLeagues(String country) async {
    final response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/leagues?country=$country'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/leagues?id=$id'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
