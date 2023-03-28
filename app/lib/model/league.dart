class League {
  final int id;
  final String name;
  final String country;
  final String logo;
  //final String season;


  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    //required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['league']['id'],
      name: json['league']['name'],
      country: json['country']['name'],
      logo: json['league']['logo'],
      //season: json['seasons'].last()['year'],
    );
  }

  factory League.fromJsonMatch(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      //season: json['season'],
    );
  }
}
