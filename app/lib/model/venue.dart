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

  factory Venue.fromJson(Map<String, dynamic> json) {
    // print('VENUE id: ${json['id'] ?? 0} name: ${json['name'] ?? ''} address: ${json['address'] ?? ''} city: ${json['city'] ?? ''} country: ${json['country'] ?? ''} capacity: ${json['capacity'] ?? 0} surface: ${json['surface'] ?? ''} image: ${json['image'] ?? ''}\n');
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
    // print('VENUE id: ${json['id'] ?? 0} name: ${json['name'] ?? ''} city: ${json['city'] ?? ''}\n');
    return Venue(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      city: json['city'] ?? '',
    );
  }
}
