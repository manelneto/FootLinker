import 'package:app/controller/location_fetcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Localização', () {
    test('Cálculo da Distância', () {
      LocationFetcher locationFetcher = LocationFetcher();
      double lat1 = 41.1838592;
      double lon1 = -8.6983636;
      double lat2 = 39.9629099;
      double lon2 = -9.9876305;
      expect(locationFetcher.calculateDistance(lat1, lon1, lat2, lon2),
          closeTo(174, 0.1));
    });
  });
}
