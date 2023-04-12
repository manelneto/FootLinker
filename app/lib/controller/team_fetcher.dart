import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_management.dart';
import '../model/team.dart';

class TeamFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Team>> fetchTeams(String country) async {
    final response = await http.get(
      Uri.parse('${apiManagement.url}teams?country=$country'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> teamsList = body['response'];
      List<Team> teams =
          teamsList.map((dynamic item) => Team.fromJson(item)).toList();
      return teams;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Team> fetchTeam(int id) async {
    final response = await http.get(
      Uri.parse('${apiManagement.url}teams?id=$id'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> teamsList = body['response'];
      List<Team> teams =
          teamsList.map((dynamic item) => Team.fromJson(item)).toList();
      return teams[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
