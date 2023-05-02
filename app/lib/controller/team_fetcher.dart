import 'package:app/api_management.dart';
import 'package:app/model/team.dart';
import 'package:http/http.dart' as http;

class TeamFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Team>> fetchTeamsByCountry(
    String country,
    http.Client client,
  ) async {
    List<Team> teams;
    try {
      List<dynamic> teamsList =
          await apiManagement.sendRequest('teams?country=$country', client);
      teams = teamsList.map((dynamic item) => Team.fromJson(item)).toList();
    } on Exception catch (e) {
      teams = [Team.fromException(e)];
    }
    return teams;
  }
}
