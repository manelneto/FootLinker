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
    this.national = false,
    required this.logo,
  });

  factory Team.fromException(Exception exception) {
    return Team(
      id: -1,
      name: exception.toString(),
      code: 'code',
      country: 'country',
      founded: -1,
      national: false,
      logo: 'https://picsum.photos/200',
    );
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['team']['id'] ?? -1,
      name: json['team']['name'] ?? '',
      code: json['team']['code'] ?? '',
      country: json['team']['country'] ?? '',
      founded: json['team']['founded'] ?? -1,
      national: json['team']['national'] ?? false,
      logo: json['team']['logo'] ?? '',
    );
  }

  factory Team.fromJsonMatch(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'country': country,
        'founded': founded,
        'national': national,
        'logo': logo,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Team && id == other.id);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      country.hashCode ^
      founded.hashCode ^
      national.hashCode ^
      logo.hashCode;
}
