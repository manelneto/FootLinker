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
    var venue = json['response'][0];
    return Venue(
      id: venue['id'],
      name: venue['name'],
      address: venue['address'],
      city: venue['city'],
      capacity: venue['capacity'],
      surface: venue['surface'],
      image: venue['image'],
    );
  }

  factory Venue.fromJsonMatch(Map<String, dynamic> venue) {
    return Venue.fromMatch(
      id: venue['id'],
      name: venue['name'],
      city: venue['city'],
    );
  }
}
