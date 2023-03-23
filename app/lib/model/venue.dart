class Venue {
  final int id;
  final String name;
  String address = "";
  final String city;
  int capacity = 0;
  String surface = "";
  String image = "";

  Venue.fromMatch({
    required this.id,
    required this.name,
    required this.city,
  });

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.capacity,
    required this.surface,
    required this.image,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      capacity: json['capacity'],
      surface: json['surface'],
      image: json['image'],
    );
  }
}
