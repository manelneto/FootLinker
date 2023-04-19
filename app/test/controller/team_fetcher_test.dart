import 'package:app/api_management.dart';
import 'package:app/controller/team_fetcher.dart';
import 'package:app/model/team.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Team Fetcher', () {
    ApiManagement apiManagement = ApiManagement();
    TeamFetcher teamFetcher = TeamFetcher();

    final client = MockClient();
    when(
      client.get(
        Uri.parse('${apiManagement.url}teams?country=test'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"team": {"id": 33, "name": "Manchester United", "code": "MUN", "country": "England", "founded": 1878, "national": false, "logo": "https://media.api-sports.io/football/teams/33.png"}, "venue": {"id": 556, "name": "Old Trafford", "address": "Sir Matt Busby Way", "city": "Manchester", "capacity": 76212, "surface": "grass", "image": "https://media.api-sports.io/football/venues/556.png"}}]}',
        200,
      ),
    );
    when(
      client.get(
        Uri.parse('${apiManagement.url}teams?country=exception'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    final Team team = Team.fromJson({
      'team': {
        'id': 33,
        'name': 'Manchester United',
        'code': 'MUN',
        'country': 'England',
        'founded': 1878,
        'national': false,
        'logo': 'https://media.api-sports.io/football/teams/33.png',
      },
      'venue': {
        'id': 556,
        'name': 'Old Trafford',
        'address': 'Sir Matt Busby Way',
        'city': 'Manchester',
        'capacity': 76212,
        'surface': 'grass',
        'image': 'https://media.api-sports.io/football/venues/556.png',
      },
    });

    test('Equipas de um país', () async {
      final teams = await teamFetcher.fetchTeamsByCountry('test', client);
      expect(teams, isA<List<Team>>());
      expect(teams.length, 1);
      expect(teams[0], team);
    });

    test('Equipas de um país - Exceção', () async {
      final teams = await teamFetcher.fetchTeamsByCountry('exception', client);
      expect(teams, isA<List<Team>>());
      expect(teams.length, 1);
      expect(teams[0], Team.fromException(Exception('404 - Not Found')));
    });
  });
}
