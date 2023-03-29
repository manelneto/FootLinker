import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/match.dart';

class MatchFetcher {
  Future<List<Match>> fetchMatchesByLeague(int league, int number) async {
    final response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/fixtures?league=$league&next=$number'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/fixtures?id=$id'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
