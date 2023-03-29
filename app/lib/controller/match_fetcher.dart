import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_management.dart';
import '../model/match.dart';

class MatchFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Match>> fetchMatchesByLeague(int league, int number) async {
    final response = await http.get(
        Uri.parse('${apiManagement.url}fixtures?league=$league&next=$number'),
        headers: apiManagement.headers,
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
        Uri.parse('${apiManagement.url}fixtures?id=$id'),
        headers: apiManagement.headers,
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
