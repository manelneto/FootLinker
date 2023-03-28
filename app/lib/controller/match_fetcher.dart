import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/match.dart';

class MatchFetcher {
  Future<List<Match>> fetchMatches(int league, int number) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/fixtures?league=$league&next=$number'),
        headers: {
          'x-rapidapi-key': '236387583694a852afa31bbc5eaa0014',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
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
        Uri.parse('https://v3.football.api-sports.io/fixtures?id=$id'),
        headers: {
          'x-rapidapi-key': '236387583694a852afa31bbc5eaa0014',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
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
