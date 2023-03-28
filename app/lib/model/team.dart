class Team {
  final int id;
  final String name;
  final String code;
  final String country;
  final int founded;
  final bool national;
  final String logo;

  Team({
    required this.id,
    required this.name,
    this.code = '',
    this.country = '',
    this.founded = 0,
    required this.national,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['team']['id'] ?? 0,
      name: json['team']['name'] ?? '',
      code: json['team']['code'] ?? '',
      country: json['team']['country'] ?? '',
      founded: json['team']['founded'] ?? 0,
      national: json['team']['national'] ?? false,
      logo: json['team']['logo'] ?? "",
    );
  }

  factory Team.fromJsonMatch(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      national: json['team']['national'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}
