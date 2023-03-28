class Team {
  final int id;
  final String name;
  final String logo;
  String code;
  String country;
  int founded;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    this.code = "",
    this.country = "",
    this.founded = 0,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['team']['id'],
      name: json['team']['name'],
      logo: json['team']['logo'],
      code: json['team']['code'],
      country: json['team']['country'],
      founded: json['team']['founded'],
    );
  }

  factory Team.fromJsonMatch(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
