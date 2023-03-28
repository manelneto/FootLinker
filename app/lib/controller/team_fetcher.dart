import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/team.dart';

class TeamFetcher {
  Future<List<Team>> fetchTeams(String country) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/teams?country=$country'),
        headers: {
          'x-rapidapi-key': 'XXX',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> teamsList = body['response'];
      List<Team> teams = teamsList.map((dynamic item) => Team.fromJson(item)).toList();
      return teams;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Team> fetchTeam(int id) async {
    final response = await http.get(
        Uri.parse('https://v3.football.api-sports.io/teams?id=$id'),
        headers: {
          'x-rapidapi-key': 'XXX',
          'x-rapidapi-host': 'v3.football.api-sports.io',
        }
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> teamsList = body['response'];
      List<Team> teams = teamsList.map((dynamic item) => Team.fromJson(item)).toList();
      return teams[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
