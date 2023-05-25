import 'package:app/model/league.dart';
import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/model/venue.dart';
import 'package:app/states/schedule_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
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
    DocumentReference<Map<String, dynamic>> user =
        FakeFirebaseFirestore().collection('users').doc('test');

    test('Calendário começa vazio', () async {
      ScheduleState scheduleState = ScheduleState();
      expect(scheduleState.schedule.isEmpty, isTrue);
    });

    test('Adicionar jogo ao calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.toggleMatch(match0, user);
      expect(scheduleState.schedule.length, 1);
      expect(scheduleState.schedule[0], match0);
    });

    test('Remover jogo do calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.toggleMatch(match0, user);
      scheduleState.toggleMatch(match0, user);
      expect(scheduleState.schedule.length, 0);
    });

    test('Ordenação do calendário', () async {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.toggleMatch(match1, user);
      scheduleState.toggleMatch(match0, user);
      expect(scheduleState.schedule.length, 2);
      expect(scheduleState.schedule[0], match0);
      expect(scheduleState.schedule[1], match1);
    });

    test('Atualização do calendário depois de seguir equipa', () {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.updateScheduleAfterFollow([match0, match1], user);
      expect(scheduleState.schedule.length, 2);
      expect(scheduleState.schedule[0], match0);
      expect(scheduleState.schedule[1], match1);
    });

    test('Atualização do calendário depois de deixar de seguir equipa', () {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.toggleMatch(match0, user);
      scheduleState.toggleMatch(match1, user);
      scheduleState.updateScheduleAfterUnfollow(away, [home], user);
      expect(scheduleState.schedule.length, 2);
      expect(scheduleState.schedule[0], match0);
      expect(scheduleState.schedule[1], match1);
    });

    test('Atualização do calendário depois de deixar de seguir equipas', () {
      ScheduleState scheduleState = ScheduleState();
      scheduleState.toggleMatch(match0, user);
      scheduleState.toggleMatch(match1, user);
      scheduleState.updateScheduleAfterUnfollow(away, [home], user);
      scheduleState.updateScheduleAfterUnfollow(home, [], user);
      expect(scheduleState.schedule.length, 0);
    });
  });
}
