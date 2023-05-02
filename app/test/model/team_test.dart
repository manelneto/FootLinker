import 'package:app/model/team.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Equipa', () {
    test('Equipa a partir de Exceção', () async {
      Exception exception = Exception('exception');
      Team team = Team.fromException(exception);

      expect(team.id, -1);
      expect(team.name, exception.toString());
      expect(team.code, 'code');
      expect(team.country, 'country');
      expect(team.founded, -1);
      expect(team.national, false);
      expect(team.logo, 'https://picsum.photos/200');
    });

    test('Equipa a partir de JSON', () async {
      Map<String, dynamic> json = {
        'team': {
          'id': 33,
          'name': 'Manchester United',
          'code': 'MUN',
          'country': 'England',
          'founded': 1878,
          'national': false,
          'logo': 'https://media.api-sports.io/football/teams/33.png'
        },
        'venue': {
          'id': 556,
          'name': 'Old Trafford',
          'address': 'Sir Matt Busby Way',
          'city': 'Manchester',
          'capacity': 76212,
          'surface': 'grass',
          'image': 'https://media.api-sports.io/football/venues/556.png'
        }
      };

      Team team = Team.fromJson(json);
      expect(team.id, 33);
      expect(team.name, 'Manchester United');
      expect(team.code, 'MUN');
      expect(team.country, 'England');
      expect(team.founded, 1878);
      expect(team.national, false);
      expect(team.logo, 'https://media.api-sports.io/football/teams/33.png');
    });

    test('Equipa para JSON', () async {
      Team team = Team(
        id: 0,
        name: 'team',
        code: 'code',
        country: 'country',
        founded: 0,
        national: false,
        logo: 'logo',
      );

      Map<String, dynamic> json = team.toJson();
      expect(json.length, 7);
      expect(json['id'], 0);
      expect(json['name'], 'team');
      expect(json['code'], 'code');
      expect(json['founded'], 0);
      expect(json['national'], false);
      expect(json['country'], 'country');
      expect(json['logo'], 'logo');
    });
  });
}
