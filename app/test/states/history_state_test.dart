import 'package:app/model/league.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:app/states/history_state.dart';
import 'package:app/model/match.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Histórico', () {
    HistoryState historyState = HistoryState();
    Venue venue = Venue(id: 0, name: 'venue', city: 'venueCity');
    League league = League(id: 0, name: 'league', country: 'leagueCountry', logo: 'leagueLogo');
    Team home = Team(id: 0, name: 'home', logo: 'homeLogo');
    Team away = Team(id: 1, name: 'away', logo: 'awayLogo');
    Match match = Match(id: 0, referee: 'referee', date: 'date', timestamp: 0, venue: venue, league: league, home: home, away: away, homeGoals: 1, awayGoals: 1);

    test('Histórico começa vazio', () async {
      expect(historyState.history.isEmpty, isTrue);
    });

    testWidgets('Adicionar jogo ao histórico', (WidgetTester tester) async {
      historyState.addMatch(match);
      expect(historyState.history.length, 1);
      expect(historyState.history[0], match);
    });

    testWidgets('Adicionar jogo duplicado ao histórico', (WidgetTester tester) async {
      historyState.addMatch(match);
      historyState.addMatch(match);
      expect(historyState.history.length, 1);
      expect(historyState.history[0], match);
    });

    testWidgets('Remover jogo do histórico', (WidgetTester tester) async {
      historyState.addMatch(match);
      historyState.removeMatch(match);
      expect(historyState.history.isEmpty, isTrue);
    });

    testWidgets('Remover jogo inexistente do histórico', (WidgetTester tester) async {
      historyState.removeMatch(match);
      expect(historyState.history.isEmpty, isTrue);
    });
  });
}
