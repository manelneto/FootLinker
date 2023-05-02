import 'package:app/api_management.dart';
import 'package:app/model/league.dart';
import 'package:http/http.dart' as http;

class LeagueFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<League>> fetchLeaguesByCountry(
    String country,
    http.Client client,
  ) async {
    List<League> leagues;
    try {
      List<dynamic> leaguesList =
          await apiManagement.sendRequest('leagues?country=$country', client);
      leagues =
          leaguesList.map((dynamic item) => League.fromJson(item)).toList();
    } on Exception catch (e) {
      leagues = [League.fromException(e)];
    }
    return leagues;
  }
}
