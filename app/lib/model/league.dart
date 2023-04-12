class League {
  final int id;
  final String name;
  String type;
  final String country;
  final String logo;

  //final String season;

  League({
    required this.id,
    required this.name,
    this.type = '',
    required this.country,
    required this.logo,
    //required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    // print('LEAGUE id: ${json['id'] ?? 0} name: ${json['name'] ?? ''} type: ${json['league']['type'] ?? ''} country: ${json['country'] ?? ''} logo: ${json['logo'] ?? ''}\n');
    return League(
      id: json['league']['id'] ?? 0,
      name: json['league']['name'] ?? '',
      type: json['league']['type'] ?? '',
      country: json['country']['name'] ?? '',
      logo: json['league']['logo'] ?? '',
      //season: json['seasons'].last()['year'],
    );
  }

  factory League.fromJsonMatch(Map<String, dynamic> json) {
    // print('LEAGUE id: ${json['id'] ?? 0} name: ${json['name'] ?? ''} country: ${json['country'] ?? ''} logo: ${json['logo'] ?? ''}\n');
    return League(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      logo: json['logo'] ?? '',
      //season: json['season'],
    );
  }
}
