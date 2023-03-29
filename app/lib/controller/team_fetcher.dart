import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/team.dart';

class TeamFetcher {
  Future<List<Team>> fetchTeams(String country) async {
    final response = await http.get(
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/teams?country=$country'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/teams?id=$id'),
        headers: {
          'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
          'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
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
