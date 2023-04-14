import 'package:app/api_management.dart';
import 'package:app/model/team.dart';

class TeamFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Team>> fetchTeamsByCountry(String country) async {
    List<Team> teams;
    try {
      List<dynamic> teamsList =
          await apiManagement.sendRequest('teams?country=$country');
      teams = teamsList.map((dynamic item) => Team.fromJson(item)).toList();
    } on Exception catch (e) {
      teams = [Team.fromException(e)];
    }
    return teams;
  }
}
