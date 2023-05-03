import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiManagement {
  String url = 'https://api-football-v1.p.rapidapi.com/v3/';
  Map<String, String> headers = {
    'X-RapidAPI-Key': '78d157beb9msh3bce1cfdd258e44p1ab226jsn8740670e3c9a',
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
  };

  Future<dynamic> sendRequest(String request, http.Client client) async {
    final response = await client.get(
      Uri.parse(url + request),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body.containsKey('errors') && body['errors'].length > 0) {
        throw Exception(body['errors'][0]);
      }
      List<dynamic> list = body['response'];
      return list;
    } else {
      throw Exception('${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
