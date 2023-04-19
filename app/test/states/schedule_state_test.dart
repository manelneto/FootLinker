import 'package:app/model/league.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:app/states/schedule_state.dart';
import 'package:app/model/match.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calendário', () {
    ScheduleState scheduleState = ScheduleState();
    Venue venue = Venue(id: 0, name: 'venue', city: 'venueCity');
    League league = League(id: 0, name: 'league', country: 'leagueCountry', logo: 'leagueLogo');
    Team home = Team(id: 0, name: 'home', logo: 'homeLogo');
    Team away = Team(id: 1, name: 'away', logo: 'awayLogo');
    Match match = Match(id: 0, referee: 'referee', date: 'date', timestamp: 0, venue: venue, league: league, home: home, away: away, homeGoals: -1, awayGoals: -1);

    test('Calendário começa vazio', () async {
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    testWidgets('Adicionar jogo ao calendário', (WidgetTester tester) async {
      scheduleState.addMatch(match);
      expect(scheduleState.schedule.length, 1);
      expect(scheduleState.schedule[0], match);
    });

    testWidgets('Adicionar jogo duplicado ao calendário', (WidgetTester tester) async {
      scheduleState.addMatch(match);
      scheduleState.addMatch(match);
      expect(scheduleState.schedule.length, 1);
      expect(scheduleState.schedule[0], match);
    });

    testWidgets('Remover jogo do calendário', (WidgetTester tester) async {
      scheduleState.addMatch(match);
      scheduleState.removeMatch(match);
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    testWidgets('Remover jogo inexistente do calendário', (WidgetTester tester) async {
      scheduleState.removeMatch(match);
      expect(scheduleState.schedule.isEmpty, isTrue);
    });
  });
}
