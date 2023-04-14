import 'package:app/model/league.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';

class Match {
  final int id;
  final String referee;
  final String date;
  final int timestamp;
  final Venue venue;
  final League league;
  final Team home;
  final Team away;
  final int homeGoals;
  final int awayGoals;

  Match({
    required this.id,
    required this.referee,
    required this.date,
    required this.timestamp,
    required this.venue,
    required this.league,
    required this.home,
    required this.away,
    required this.homeGoals,
    required this.awayGoals,
  });

  factory Match.fromException(Exception e) {
    return Match(
      id: -1,
      referee: 'referee',
      date: 'date',
      timestamp: -1,
      venue: Venue.fromException(e),
      league: League.fromException(e),
      home: Team.fromException(e),
      away: Team.fromException(e),
      homeGoals: -1,
      awayGoals: -1,
    );
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['fixture']['id'] ?? -1,
      referee: json['fixture']['referee'] ?? '',
      date: json['fixture']['date'] ?? '',
      timestamp: json['fixture']['timestamp'] ?? -1,
      venue: Venue.fromJsonMatch(json['fixture']['venue']),
      league: League.fromJsonMatch(json['league']),
      home: Team.fromJsonMatch(json['teams']['home']),
      away: Team.fromJsonMatch(json['teams']['away']),
      homeGoals: json['goals']['home'] ?? -1,
      awayGoals: json['goals']['away'] ?? -1,
    );
  }

  void show() {
    print(
        'MATCH id: $id referee: $referee date: $date timestamp: $timestamp venue: ${venue.name} league: ${league.name} home: ${home.name} away: ${away.name} homeGoals: $homeGoals awayGoals: $awayGoals\n');
  }
}
