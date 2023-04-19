import 'package:app/api_management.dart';
import 'package:app/controller/venue_fetcher.dart';
import 'package:app/model/venue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Venue Fetcher', () {
    ApiManagement apiManagement = ApiManagement();
    VenueFetcher venueFetcher = VenueFetcher();

    final client = MockClient();
    when(
      client.get(
        Uri.parse('${apiManagement.url}venues?country=test'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response(
        '{"response": [{"id": 556, "name": "Old Trafford", "address": "Sir Matt Busby Way", "city": "Manchester", "country": "England", "capacity": 76212, "surface": "grass", "image": "https://media.api-sports.io/football/venues/556.png"}]}',
        200,
      ),
    );
    when(
      client.get(
        Uri.parse('${apiManagement.url}venues?country=exception'),
        headers: apiManagement.headers,
      ),
    ).thenAnswer(
      (_) async => http.Response('Not Found', 404, reasonPhrase: 'Not Found'),
    );

    final Venue venue = Venue.fromJson({
      'id': 556,
      'name': 'Old Trafford',
      'address': 'Sir Matt Busby Way',
      'city': 'Manchester',
      'country': 'England',
      'capacity': 76212,
      'surface': 'grass',
      'image': 'https://media.api-sports.io/football/venues/556.png',
    });

    test('Estádios de um país', () async {
      final venues = await venueFetcher.fetchVenuesByCountry('test', client);
      expect(venues, isA<List<Venue>>());
      expect(venues.length, 1);
      expect(venues[0], venue);
    });

    test('Estádios de um país - Exceção', () async {
      final venues =
          await venueFetcher.fetchVenuesByCountry('exception', client);
      expect(venues, isA<List<Venue>>());
      expect(venues.length, 1);
      expect(venues[0], Venue.fromException(Exception('404 - Not Found')));
    });
  });
}
