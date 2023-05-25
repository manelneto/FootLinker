import 'package:app/model/league.dart';
import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:app/states/history_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Histórico', () {
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
      homeGoals: 1,
      awayGoals: 1,
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
      homeGoals: 1,
      awayGoals: 1,
    );
    DocumentReference<Map<String, dynamic>> user =
        FakeFirebaseFirestore().collection('users').doc('test');

    test('Histórico começa vazio', () async {
      HistoryState historyState = HistoryState();
      expect(historyState.history.isEmpty, isTrue);
    });

    test('Adicionar jogo ao histórico', () async {
      HistoryState historyState = HistoryState();
      historyState.toggleMatch(match0, user);
      expect(historyState.history.length, 1);
      expect(historyState.history[0], match0);
    });

    test('Remover jogo do histórico', () async {
      HistoryState historyState = HistoryState();
      historyState.toggleMatch(match0, user);
      historyState.toggleMatch(match0, user);
      expect(historyState.history.isEmpty, isTrue);
    });

    test('Ordenação do histórico', () async {
      HistoryState historyState = HistoryState();
      historyState.toggleMatch(match1, user);
      historyState.toggleMatch(match0, user);
      expect(historyState.history.length, 2);
      expect(historyState.history[0], match1);
      expect(historyState.history[1], match0);
    });
  });
}
