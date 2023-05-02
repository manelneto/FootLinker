import 'package:app/model/venue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Estádio', () {
    test('Estádio a partir de Exceção', () async {
      Exception exception = Exception('exception');
      Venue venue = Venue.fromException(exception);

      expect(venue.id, -1);
      expect(venue.name, exception.toString());
      expect(venue.city, 'city');
    });

    test('Estádio a partir de JSON', () async {
      Map<String, dynamic> json = {
        'id': 556,
        'name': 'Old Trafford',
        'address': 'Sir Matt Busby Way',
        'city': 'Manchester',
        'country': 'England',
        'capacity': 76212,
        'surface': 'grass',
        'image': 'https://media.api-sports.io/football/venues/556.png'
      };

      Venue venue = Venue.fromJson(json);
      expect(venue.id, 556);
      expect(venue.name, 'Old Trafford');
      expect(venue.address, 'Sir Matt Busby Way');
      expect(venue.city, 'Manchester');
      expect(venue.country, 'England');
      expect(venue.capacity, 76212);
      expect(venue.surface, 'grass');
      expect(
        venue.image,
        'https://media.api-sports.io/football/venues/556.png',
      );
    });

    test('Estádio para JSON', () async {
      Venue venue = Venue(
        id: 0,
        name: 'venue',
        address: 'address',
        city: 'city',
        country: 'country',
        capacity: 0,
        surface: 'surface',
        image: 'image',
      );

      Map<String, dynamic> json = venue.toJson();
      expect(json.length, 8);
      expect(json['id'], 0);
      expect(json['name'], 'venue');
      expect(json['address'], 'address');
      expect(json['city'], 'city');
      expect(json['country'], 'country');
      expect(json['surface'], 'surface');
      expect(json['image'], 'image');
    });
  });
}
