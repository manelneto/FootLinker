import 'package:app/model/league.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';

class Match {
  final int id;
  final String referee;
  final String date;
  final String time;
  final Venue venue;
  final League league;
  final Team home;
  final Team away;
  final String score;

  Match({
    required this.id,
    required this.referee,
    required this.date,
    required this.time,
    required this.venue,
    required this.league,
    required this.home,
    required this.away,
    required this.score,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      referee: json['referee'],
      date: json['date'],
      time: json['date'],
      venue: Venue.fromJson(json['venue']),
      league: League.fromJson(json['league']),
      home: Team.fromJson(json['teams']['home']),
      away: Team.fromJson(json['teams']['away']),
      score: json['score']['fulltime']['home'] + ' - ' + json['score']['fulltime']['away'],
    );
  }
}
