import 'package:app/api_management.dart';
import 'package:app/controller/match_fetcher.dart';
import 'package:app/model/match.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Match Fetcher', () {
    ApiManagement apiManagement = ApiManagement();
    MatchFetcher matchFetcher = MatchFetcher();

    final client = MockClient();
    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?league=0&next=0'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"fixture": {"id": 239625, "referee": null, "timezone": "UTC", "date": "2020-02-06T14:00:00+00:00", "timestamp": 1580997600, "periods": {}, "venue": {"id": 1887, "name": "Stade Municipal", "city": "Oued Zem"}, "status": {}}, "league": {"id": 200, "name": "Botola Pro", "country": "Morocco", "logo": "https://media.api-sports.io/football/leagues/115.png", "flag": "https://media.api-sports.io/flags/ma.svg", "season": 2019, "round": "Regular Season - 14"}, "teams": {"home": {"id": 967, "name": "Rapide Oued ZEM", "logo": "https://media.api-sports.io/football/teams/967.png", "winner": false}, "away": {"id": 968, "name": "Wydad AC", "logo": "https://media.api-sports.io/football/teams/968.png", "winner": true}}, "goals": {"home": 0, "away": 1}}]}',
        200,
      ),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?league=0&last=0'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"fixture": {"id": 239625, "referee": null, "timezone": "UTC", "date": "2020-02-06T14:00:00+00:00", "timestamp": 1580997600, "periods": {}, "venue": {"id": 1887, "name": "Stade Municipal", "city": "Oued Zem"}, "status": {}}, "league": {"id": 200, "name": "Botola Pro", "country": "Morocco", "logo": "https://media.api-sports.io/football/leagues/115.png", "flag": "https://media.api-sports.io/flags/ma.svg", "season": 2019, "round": "Regular Season - 14"}, "teams": {"home": {"id": 967, "name": "Rapide Oued ZEM", "logo": "https://media.api-sports.io/football/teams/967.png", "winner": false}, "away": {"id": 968, "name": "Wydad AC", "logo": "https://media.api-sports.io/football/teams/968.png", "winner": true}}, "goals": {"home": 0, "away": 1}}]}',
        200,
      ),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?league=-1&next=-1'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?league=-1&last=-1'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?team=0&status=NS&season=2022'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"fixture": {"id": 239625, "referee": null, "timezone": "UTC", "date": "2020-02-06T14:00:00+00:00", "timestamp": 1580997600, "periods": {}, "venue": {"id": 1887, "name": "Stade Municipal", "city": "Oued Zem"}, "status": {}}, "league": {"id": 200, "name": "Botola Pro", "country": "Morocco", "logo": "https://media.api-sports.io/football/leagues/115.png", "flag": "https://media.api-sports.io/flags/ma.svg", "season": 2019, "round": "Regular Season - 14"}, "teams": {"home": {"id": 967, "name": "Rapide Oued ZEM", "logo": "https://media.api-sports.io/football/teams/967.png", "winner": false}, "away": {"id": 968, "name": "Wydad AC", "logo": "https://media.api-sports.io/football/teams/968.png", "winner": true}}, "goals": {"home": 0, "away": 1}}]}',
        200,
      ),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?team=0&last=0'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"fixture": {"id": 239625, "referee": null, "timezone": "UTC", "date": "2020-02-06T14:00:00+00:00", "timestamp": 1580997600, "periods": {}, "venue": {"id": 1887, "name": "Stade Municipal", "city": "Oued Zem"}, "status": {}}, "league": {"id": 200, "name": "Botola Pro", "country": "Morocco", "logo": "https://media.api-sports.io/football/leagues/115.png", "flag": "https://media.api-sports.io/flags/ma.svg", "season": 2019, "round": "Regular Season - 14"}, "teams": {"home": {"id": 967, "name": "Rapide Oued ZEM", "logo": "https://media.api-sports.io/football/teams/967.png", "winner": false}, "away": {"id": 968, "name": "Wydad AC", "logo": "https://media.api-sports.io/football/teams/968.png", "winner": true}}, "goals": {"home": 0, "away": 1}}]}',
        200,
      ),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?team=-1&status=NS&season=2022'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    when(
      client.get(
        Uri.parse('${apiManagement.url}fixtures?team=-1&last=-1'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    final Match match = Match.fromJson({
      'fixture': {
        'id': 239625,
        'referee': null,
        'timezone': 'UTC',
        'date': '2020-02-06T14:00:00+00:00',
        'timestamp': 1580997600,
        'periods': {},
        'venue': {'id': 1887, 'name': 'Stade Municipal', 'city': 'Oued Zem'},
        'status': {},
      },
      'league': {
        'id': 200,
        'name': 'Botola Pro',
        'country': 'Morocco',
        'logo': 'https://media.api-sports.io/football/leagues/115.png',
        'flag': 'https://media.api-sports.io/flags/ma.svg',
        'season': 2019,
        'round': 'Regular Season - 14',
      },
      'teams': {
        'home': {
          'id': 967,
          'name': 'Rapide Oued ZEM',
          'logo': 'https://media.api-sports.io/football/teams/967.png',
          'winner': false,
        },
        'away': {
          'id': 968,
          'name': 'Wydad AC',
          'logo': 'https://media.api-sports.io/football/teams/968.png',
          'winner': true,
        },
      },
      'goals': {
        'home': 0,
        'away': 1,
      },
    });

    test('Próximos Jogos de uma Liga', () async {
      final matches = await matchFetcher.fetchNextMatchesByLeague(0, 0, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], match);
    });

    test('Próximos Jogos de uma Liga - Exceção', () async {
      final matches =
          await matchFetcher.fetchNextMatchesByLeague(-1, -1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
    });

    test('Últimos Jogos de uma Liga', () async {
      final matches = await matchFetcher.fetchLastMatchesByLeague(0, 0, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], match);
    });

    test('Últimos Jogos de uma Liga - Exceção', () async {
      final matches =
          await matchFetcher.fetchLastMatchesByLeague(-1, -1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
    });

    test('Jogos de uma Liga', () async {
      final matches = await matchFetcher.fetchMatchesByLeague(0, 0, client);
      expect(
        matches,
        isA<List<Match>>(),
      );
      expect(matches.length, 2);
      expect(matches[0], match);
      expect(matches[1], match);
    });

    test('Jogos de uma Liga - Exceção', () async {
      final matches = await matchFetcher.fetchMatchesByLeague(-1, -1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 2);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
      expect(matches[1], Match.fromException(Exception('404 - Not Found')));
    });

    test('Jogos Agendados de uma Equipa', () async {
      final matches = await matchFetcher.fetchScheduledMatchesByTeam(0, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], match);
    });

    test('Jogos Agendados de uma Equipa - Exceção', () async {
      final matches =
          await matchFetcher.fetchScheduledMatchesByTeam(-1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
    });

    test('Últimos Jogos de uma Equipa', () async {
      final matches = await matchFetcher.fetchLastMatchesByTeam(0, 0, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], match);
    });

    test('Últimos Jogos de uma Equipa - Exceção', () async {
      final matches =
          await matchFetcher.fetchLastMatchesByLeague(-1, -1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 1);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
    });

    test('Jogos de uma Equipa', () async {
      final matches = await matchFetcher.fetchMatchesByTeam(0, 0, client);
      expect(
        matches,
        isA<List<Match>>(),
      );
      expect(matches.length, 2);
      expect(matches[0], match);
      expect(matches[1], match);
    });

    test('Jogos de uma Equipa - Exceção', () async {
      final matches = await matchFetcher.fetchMatchesByTeam(-1, -1, client);
      expect(matches, isA<List<Match>>());
      expect(matches.length, 2);
      expect(matches[0], Match.fromException(Exception('404 - Not Found')));
      expect(matches[1], Match.fromException(Exception('404 - Not Found')));
    });
  });
}
