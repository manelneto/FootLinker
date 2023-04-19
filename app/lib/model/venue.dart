class Venue {
  final int id;
  final String name;
  final String address;
  final String city;
  final String country;
  final int capacity;
  final String surface;
  final String image;

  Venue({
    required this.id,
    required this.name,
    this.address = '',
    required this.city,
    this.country = '',
    this.capacity = 0,
    this.surface = '',
    this.image = '',
  });

  factory Venue.fromException(Exception e) {
    return Venue(
      id: -1,
      name: e.toString(),
      city: 'city',
    );
  }

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      capacity: json['capacity'] ?? 0,
      surface: json['surface'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory Venue.fromJsonMatch(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'city': city,
        'country': country,
        'capacity': capacity,
        'surface': surface,
        'image': image,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Venue &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          city == other.city &&
          country == other.country &&
          capacity == other.capacity &&
          surface == other.surface &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      city.hashCode ^
      country.hashCode ^
      capacity.hashCode ^
      surface.hashCode ^
      image.hashCode;
}
