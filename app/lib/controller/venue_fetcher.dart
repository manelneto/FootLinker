import 'package:app/api_management.dart';
import 'package:app/model/venue.dart';

class VenueFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Venue>> fetchVenuesByCountry(String country) async {
    List<Venue> venues;
    try {
      List<dynamic> venuesList =
          await apiManagement.sendRequest('venues?country=$country');
      venues = venuesList.map((dynamic item) => Venue.fromJson(item)).toList();
    } on Exception catch (e) {
      venues = [Venue.fromException(e)];
    }
    return venues;
  }
}
