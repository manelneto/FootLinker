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
    var match = json['response'][0];
    return Match(
      id: match['fixture']['id'],
      referee: match['fixture']['referee'],
      date: match['fixture']['date'],
      time: match['fixture']['date'],
      venue: Venue.fromJsonMatch(match['fixture']['venue']),
      league: League.fromJson(match['league']),
      home: Team.fromJsonMatch(match['teams']['home']),
      away: Team.fromJsonMatch(match['teams']['away']),
      score: '${match['score']['fulltime']['home']} - ${match['score']['fulltime']['away']}',
    );
  }
}
