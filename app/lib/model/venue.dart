class Venue {
  final int id;
  final String name;
  final String address;
  final String city;
  final int capacity;
  final String surface;
  final String image;
  final double lat;
  final double lng;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.capacity,
    required this.surface,
    required this.image,
    required this.lat,
    required this.lng});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      capacity: json['capacity'],
      surface: json['surface'],
      image: json['image'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
