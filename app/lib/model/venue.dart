class Venue {
  final int id;
  final String name;
  final String city;
  String address;
  String country;
  int capacity;
  String surface;
  String image;

  Venue({
    required this.id,
    required this.name,
    required this.city,
    this.address = "",
    this.country = "",
    this.capacity = 0,
    this.surface = "",
    this.image = "",
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      country: json['country'],
      capacity: json['capacity'],
      surface: json['surface'],
      image: json['image'],
    );
  }

  factory Venue.fromJsonTeam(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      capacity: json['capacity'],
      surface: json['surface'],
      image: json['image'],
    );
  }

  factory Venue.fromJsonMatch(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      city: json['city'],
    );
  }
}
