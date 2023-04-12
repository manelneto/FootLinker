import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_management.dart';
import '../model/league.dart';

class LeagueFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<League>> fetchLeagues(String country) async {
    final response = await http.get(
      Uri.parse("${apiManagement.url}leagues?country=$country"),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> leaguesList = body['response'];
      List<League> leagues =
          leaguesList.map((dynamic item) => League.fromJson(item)).toList();
      return leagues;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<League> fetchLeague(int id) async {
    final response = await http.get(
      Uri.parse('${apiManagement.url}leagues?id=$id'),
      headers: apiManagement.headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> leaguesList = body['response'];
      List<League> leagues =
          leaguesList.map((dynamic item) => League.fromJson(item)).toList();
      return leagues[0];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
