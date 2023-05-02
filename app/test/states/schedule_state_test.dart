import 'package:app/model/league.dart';
import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:app/states/schedule_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calendário', () {
    Venue venue = Venue(id: 0, name: 'venue', city: 'venueCity');
    League league = League(
      id: 0,
      name: 'league',
      country: 'leagueCountry',
      logo: 'leagueLogo',
    );
    Team home = Team(id: 0, name: 'home', logo: 'homeLogo');
    Team away = Team(id: 1, name: 'away', logo: 'awayLogo');
    Match match0 = Match(
      id: 0,
      referee: 'referee',
      date: 'date',
      timestamp: 0,
      venue: venue,
      league: league,
      home: home,
      away: away,
      homeGoals: -1,
      awayGoals: -1,
    );
    Match match1 = Match(
      id: 1,
      referee: 'referee',
      date: 'date',
      timestamp: 1,
      venue: venue,
      league: league,
      home: home,
      away: away,
      homeGoals: -1,
      awayGoals: -1,
    );

    test('Calendário começa vazio', () async {
      ScheduleState scheduleState = ScheduleState();
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    test('Adicionar jogo ao calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.addMatch(match0);
      expect(scheduleState.schedule.length, 1);
      expect(scheduleState.schedule[0], match0);
    });

    test('Adicionar jogo duplicado ao calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.addMatch(match0);
      scheduleState.addMatch(match0);
      expect(scheduleState.schedule.length, 1);
      expect(scheduleState.schedule[0], match0);
    });

    test('Remover jogo do calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.addMatch(match0);
      scheduleState.removeMatch(match0);
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    test('Remover jogo inexistente do calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.removeMatch(match0);
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    test('Ordenação do calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.addMatch(match1);
      scheduleState.addMatch(match0);
      expect(scheduleState.schedule.length, 2);
      expect(scheduleState.schedule[0], match0);
      expect(scheduleState.schedule[1], match1);
    });
  });
}
