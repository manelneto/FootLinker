class League {
  final int id;
  final String name;
  final String country;
  final String logo;
  final int season;
  final String round;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.season,
    required this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      season: json['season'],
      round: json['round'],
    );
  }
}
