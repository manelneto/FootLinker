import 'package:app/api_management.dart';
import 'package:app/model/venue.dart';
import 'package:http/http.dart' as http;

class VenueFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Venue>> fetchVenuesByCountry(
    String country,
    http.Client client,
  ) async {
    List<Venue> venues;
    try {
      List<dynamic> venuesList =
          await apiManagement.sendRequest('venues?country=$country', client);
      venues = venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
    } on Exception catch (e) {
      venues = [Venue.fromException(e)];
    }
    return venues;
  }
}
