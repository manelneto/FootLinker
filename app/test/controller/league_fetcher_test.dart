import 'package:app/api_management.dart';
import 'package:app/controller/league_fetcher.dart';
import 'package:app/model/league.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('League Fetcher', () {
    ApiManagement apiManagement = ApiManagement();
    LeagueFetcher leagueFetcher = LeagueFetcher();

    final client = MockClient();
    when(
      client.get(
        Uri.parse('${apiManagement.url}leagues?country=test'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"league": {"id": 39, "name": "Premier League", "type": "League", "logo": "https://media.api-sports.io/football/leagues/2.png"}, "country": {"name": "England", "code": "GB", "flag": "https://media.api-sports.io/flags/gb.svg"}}]}',
        200,
      ),
    );
    when(
      client.get(
        Uri.parse('${apiManagement.url}leagues?country=exception'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    final League league = League.fromJson(
      {
        'league': {
          'id': 39,
          'name': 'Premier League',
          'type': 'League',
          'logo': 'https://media.api-sports.io/football/leagues/2.png',
        },
        'country': {
          'name': 'England',
          'code': 'GB',
          'flag': 'https://media.api-sports.io/flags/gb.svg',
        },
      },
    );

    test('Ligas de um país', () async {
      final leagues = await leagueFetcher.fetchLeaguesByCountry('test', client);
      expect(leagues, isA<List<League>>());
      expect(leagues.length, 1);
      expect(leagues[0], league);
    });

    test('Ligas de um país - Exceção', () async {
      final leagues =
          await leagueFetcher.fetchLeaguesByCountry('exception', client);
      expect(leagues, isA<List<League>>());
      expect(leagues.length, 1);
      expect(leagues[0], League.fromException(Exception('404 - Not Found')));
    });
  });
}
