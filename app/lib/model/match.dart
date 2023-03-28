import 'package:app/model/league.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';

class Match {
  final int id;
  final String date;
  final int timestamp;
  final Venue venue;
  final League league;
  final Team home;
  final Team away;

  Match({
    required this.id,
    required this.date,
    required this.timestamp,
    required this.venue,
    required this.league,
    required this.home,
    required this.away,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['fixture']['id'],
      date: json['fixture']['date'],
      timestamp: json['fixture']['timestamp'],
      venue: Venue.fromJsonMatch(json['fixture']['venue']),
      league: League.fromJsonMatch(json['league']),
      home: Team.fromJsonMatch(json['teams']['home']),
      away: Team.fromJsonMatch(json['teams']['away']),
    );
  }
}
