import 'package:app/model/venue.dart';

class Team {
  final int id;
  final String name;
  String code = "";
  String country = "";
  int founded = 0;
  final String logo;

  Team.fromMatch({
    required this.id,
    required this.name,
    required this.logo,
  });

  Team({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
    required this.founded,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var team = json['response'][0]['team'];
    return Team(
        id: team['id'],
        name: team['name'],
        code: team['code'],
        country: team['country'],
        founded: team['founded'],
        logo: team['logo'],
    );
  }
}
