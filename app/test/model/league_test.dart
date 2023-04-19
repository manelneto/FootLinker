import 'package:app/model/league.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Liga', () {
    test('Liga a partir de Exceção', () async {
      Exception exception = Exception('exception');
      League league = League.fromException(exception);

      expect(league.id, -1);
      expect(league.name, exception.toString());
      expect(league.country, 'country');
      expect(league.logo, 'https://picsum.photos/200');
    });

    test('Liga a partir de JSON', () async {
      Map<String, dynamic> json = {
        'league': {
          'id': 39,
          'name': 'Premier League',
          'type': 'League',
          'logo': 'https://media.api-sports.io/football/leagues/2.png'
        },
        'country': {
          'name': 'England',
          'code': 'GB',
          'flag': 'https://media.api-sports.io/flags/gb.svg'
        },
        'seasons': [
          {
            'year': 2010,
            'start': '2010-08-14',
            'end': '2011-05-17',
            'current': false,
            'coverage': {}
          },
          {
            'year': 2011,
            'start': '2011-08-13',
            'end': '2012-05-13',
            'current': false,
            'coverage': {}
          }
        ]
      };

      League league = League.fromJson(json);
      expect(league.id, 39);
      expect(league.name, 'Premier League');
      expect(league.type, 'League');
      expect(league.country, 'England');
      expect(league.logo, 'https://media.api-sports.io/football/leagues/2.png');
    });

    test('Liga para JSON', () async {
      League league =
          League(id: 0, name: 'league', country: 'country', logo: 'logo');

      Map<String, dynamic> json = league.toJson();
      expect(json.length, 4);
      expect(json['id'], 0);
      expect(json['name'], 'league');
      expect(json['country'], 'country');
      expect(json['logo'], 'logo');
    });
  });
}
