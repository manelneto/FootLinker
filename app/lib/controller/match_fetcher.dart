import 'package:app/api_management.dart';
import 'package:app/controller/location_fetcher.dart';
import 'package:app/controller/venue_fetcher.dart';
import 'package:app/model/match.dart';
import 'package:app/model/venue.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class MatchFetcher {
  ApiManagement apiManagement = ApiManagement();

  Future<List<Match>> fetchNextMatchesByLocation(
    LocationData locationData,
    int next,
    http.Client client,
  ) async {
    List<Venue> venues =
        await VenueFetcher().fetchVenuesByCountry('portugal', client);

    Venue closestVenue = Venue(id: 0, name: 'name', city: 'city');
    double minDistance = double.maxFinite;
    LocationFetcher locationFetcher = LocationFetcher();

    for (Venue venue in venues) {
      if (venue.capacity > 5000) {
        try {
          var location = await locationFetcher.fetchCoordinates(venue.name);
          double distance = locationFetcher.calculateDistance(
            locationData.latitude,
            locationData.longitude,
            location.latitude,
            location.longitude,
          );
          if (distance < minDistance) {
            closestVenue = venue;
            minDistance = distance;
          }
        } on NoResultFoundException {
          // empty for now
        }
      }
    }

    List<Match> matches;
    try {
      List<dynamic> matchesList = await apiManagement.sendRequest(
        'fixtures?venue=${closestVenue.id}&next=$next',
        client,
      );
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchNextMatchesByLeague(
    int league,
    int next,
    http.Client client,
  ) async {
    List<Match> matches;
    try {
      List<dynamic> matchesList = await apiManagement.sendRequest(
        'fixtures?league=$league&next=$next',
        client,
      );
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchLastMatchesByLeague(
    int league,
    int last,
    http.Client client,
  ) async {
    List<Match> matches;
    try {
      List<dynamic> matchesList = await apiManagement.sendRequest(
        'fixtures?league=$league&last=$last',
        client,
      );
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchMatchesByLeague(
    int league,
    int number,
    http.Client client,
  ) async {
    List<Match> last = await fetchLastMatchesByLeague(league, number, client);
    List<Match> next = await fetchNextMatchesByLeague(league, number, client);
    List<Match> matches = last + next;
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchScheduledMatchesByTeam(
    int team,
    http.Client client,
  ) async {
    List<Match> matches;
    DateTime season = DateTime.now();
    try {
      List<dynamic> matchesList = await apiManagement.sendRequest(
        'fixtures?team=$team&status=NS&season=${season.year - 1}',
        client,
      );
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchLastMatchesByTeam(
    int team,
    int last,
    http.Client client,
  ) async {
    List<Match> matches;
    try {
      List<dynamic> matchesList = await apiManagement.sendRequest(
        'fixtures?team=$team&last=$last',
        client,
      );
      matches =
          matchesList.map((dynamic item) => Match.fromJson(item)).toList();
    } on Exception catch (e) {
      matches = [Match.fromException(e)];
    }
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }

  Future<List<Match>> fetchMatchesByTeam(
    int team,
    int number,
    http.Client client,
  ) async {
    List<Match> last = await fetchLastMatchesByTeam(team, number, client);
    List<Match> next = await fetchScheduledMatchesByTeam(team, client);
    List<Match> matches = last + next;
    matches.sort((a, b) => (a.timestamp).compareTo(b.timestamp));
    return matches;
  }
}
