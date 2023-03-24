class League {
  final int id;
  final String name;
  final String type;
  final String logo;
  final String country;

  League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
    required this.country,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    var league = json['response'][0];
    return League(
      id: league['league']['id'],
      name: league['league']['name'],
      type: league['league']['type'],
      logo: league['league']['logo'],
      country: league['country']['name'],
    );
  }
}
