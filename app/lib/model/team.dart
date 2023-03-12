import 'package:app/model/venue.dart';

class Team {
  final int id;
  final String name;
  final String code;
  final String country;
  final int founded;
  final bool national;
  final String logo;
  final Venue venue;

  Team({
    required this.id,
    required this.name,
    required this.code,
    required this.country,
    required this.founded,
    required this.national,
    required this.logo,
    required this.venue,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var team = json['response'][0]['team'];
    var venue = json['response'][0]['venue'];
    return Team(
        id: team['id'],
        name: team['name'],
        code: team['code'],
        country: team['country'],
        founded: team['founded'],
        national: team['national'],
        logo: team['logo'],
        venue: Venue.fromJson(venue),
    );
  }
}
