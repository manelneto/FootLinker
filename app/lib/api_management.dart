import 'dart:convert';

import 'package:http/http.dart' as http;

bool rapid = true;

class ApiManagement {
  String url = '';
  Map<String, String> headers = {};

  ApiManagement() {
    String urlRapidAPI = 'https://api-football-v1.p.rapidapi.com/v3/';

    Map<String, String> headersRapidAPI = {
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
      'X-RapidAPI-Key': 'f98943d9bamshd4cccfea72196b8p106219jsnd303daf9b388',
    };

    String urlFootballAPI = 'https://v3.football.api-sports.io/';

    Map<String, String> headersFootballAPI = {
      'x-rapidapi-host': 'v3.football.api-sports.io',
      'x-rapidapi-key': 'ee1436cf7c3f62f5287fee99a014da15',
    };

    if (rapid) {
      url = urlRapidAPI;
      headers = headersRapidAPI;
    } else {
      url = urlFootballAPI;
      headers = headersFootballAPI;
    }
  }

  Future<dynamic> sendRequest(String request, http.Client client) async {
    final response = await client.get(
      Uri.parse(url + request),
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (response.headers.containsKey('x-ratelimit-requests-remaining') && int.parse(response.headers['x-ratelimit-requests-remaining']!) <= 1 && !rapid) {
        rapid = true;
        throw Exception('Erro na ligação à API. Tente novamente.');
      }
      var body = jsonDecode(response.body);
      if (body.containsKey('errors') && body['errors'].length > 0) {
        rapid = true;
        throw Exception(body['errors'][0]);
      }
      List<dynamic> list = body['response'];
      return list;
    } else {
      rapid = true;
      throw Exception('${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
