class League {
  final int id;
  final String name;
  String type;
  final String country;
  final String logo;

  League({
    required this.id,
    required this.name,
    this.type = '',
    required this.country,
    required this.logo,
  });

  factory League.fromException(Exception exception) {
    return League(
      id: -1,
      name: exception.toString(),
      country: 'country',
      logo: 'https://picsum.photos/200',
    );
  }

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['league']['id'] ?? -1,
      name: json['league']['name'] ?? '',
      type: json['league']['type'] ?? '',
      country: json['country']['name'] ?? '',
      logo: json['league']['logo'] ?? '',
    );
  }

  factory League.fromJsonMatch(Map<String, dynamic> json) {
    return League(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'logo': logo,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is League && id == other.id);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      country.hashCode ^
      logo.hashCode;
}
