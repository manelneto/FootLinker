import 'package:app/model/league.dart';
import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Jogo', () {
    test('Jogo a partir de Exceção', () async {
      Exception exception = Exception('exception');
      Match match = Match.fromException(exception);

      expect(match.id, -1);
      expect(match.referee, 'referee');
      expect(match.date, 'date');
      expect(match.timestamp, -1);
      expect(match.venue, Venue.fromException(exception));
      expect(match.home, Team.fromException(exception));
      expect(match.away, Team.fromException(exception));
      expect(match.homeGoals, -1);
      expect(match.awayGoals, -1);
    });

    test('Jogo a partir de JSON', () async {
      Map<String, dynamic> json = {
        'fixture': {
          'id': 239625,
          'referee': null,
          'timezone': 'UTC',
          'date': '2020-02-06T14:00:00+00:00',
          'timestamp': 1580997600,
          'periods': {},
          'venue': {'id': 1887, 'name': 'Stade Municipal', 'city': 'Oued Zem'},
          'status': {}
        },
        'league': {
          'id': 200,
          'name': 'Botola Pro',
          'country': 'Morocco',
          'logo': 'https://media.api-sports.io/football/leagues/115.png',
          'flag': 'https://media.api-sports.io/flags/ma.svg',
          'season': 2019,
          'round': 'Regular Season - 14'
        },
        'teams': {
          'home': {
            'id': 967,
            'name': 'Rapide Oued ZEM',
            'logo': 'https://media.api-sports.io/football/teams/967.png',
            'winner': false
          },
          'away': {
            'id': 968,
            'name': 'Wydad AC',
            'logo': 'https://media.api-sports.io/football/teams/968.png',
            'winner': true
          }
        },
        'goals': {'home': 0, 'away': 1},
      };

      Match match = Match.fromJson(json);
      expect(match.id, 239625);
      expect(match.referee, '');
      expect(match.date, '2020-02-06T14:00:00+00:00');
      expect(match.timestamp, 1580997600);
      expect(
        match.venue,
        Venue(id: 1887, name: 'Stade Municipal', city: 'Oued Zem'),
      );
      expect(
        match.league,
        League(
          id: 200,
          name: 'Botola Pro',
          country: 'Morocco',
          logo: 'https://media.api-sports.io/football/leagues/115.png',
        ),
      );
      expect(
        match.home,
        Team(
          id: 967,
          name: 'Rapide Oued ZEM',
          logo: 'https://media.api-sports.io/football/teams/967.png',
        ),
      );
      expect(
        match.away,
        Team(
          id: 968,
          name: 'Wydad AC',
          logo: 'https://media.api-sports.io/football/teams/968.png',
        ),
      );
      expect(match.homeGoals, 0);
      expect(match.awayGoals, 1);
    });

    test('Jogo para JSON', () async {
      Venue venue = Venue(id: 0, name: 'venue', city: 'venueCity');
      League league = League(
        id: 0,
        name: 'league',
        country: 'leagueCountry',
        logo: 'leagueLogo',
      );
      Team home = Team(id: 0, name: 'home', logo: 'homeLogo');
      Team away = Team(id: 1, name: 'away', logo: 'awayLogo');
      Match match = Match(
        id: 0,
        referee: 'referee',
        date: 'date',
        timestamp: 0,
        venue: venue,
        league: league,
        home: home,
        away: away,
        homeGoals: 0,
        awayGoals: 0,
      );

      Map<String, dynamic> json = match.toJson();
      expect(json.length, 4);
      expect(json['fixture']['referee'], 'referee');
      expect(json['fixture']['date'], 'date');
      expect(json['fixture']['timestamp'], 0);
      expect(json['fixture']['venue'], venue.toJson());
      expect(json['league'], league.toJson());
      expect(json['teams']['home'], home.toJson());
      expect(json['teams']['away'], away.toJson());
      expect(json['goals']['home'], 0);
      expect(json['goals']['away'], 0);
    });
  });
}
