import 'package:app/model/match.dart';
import 'package:app/model/team.dart';
import 'package:app/states/followed_state.dart';
import 'package:app/states/schedule_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Favoritos', () {
    Team team = Team(id: 0, name: 'team', logo: 'logo');
    DocumentReference<Map<String, dynamic>> user =
        FakeFirebaseFirestore().collection('users').doc('test');

    test('Favoritos começa vazio', () async {
      FollowedState followedState = FollowedState();
      expect(followedState.followed.isEmpty, isTrue);
    });

    test('Adicionar equipa aos favoritos', () async {
      FollowedState followedState = FollowedState();
      followedState.toggleTeam(team, <Match>[], ScheduleState(), user);
      expect(followedState.followed.length, 1);
      expect(followedState.followed[0], team);
    });

    test('Remover equipa dos favoritos', () async {
      FollowedState followedState = FollowedState();
      followedState.toggleTeam(team, <Match>[], ScheduleState(), user);
      followedState.toggleTeam(team, <Match>[], ScheduleState(), user);
      expect(followedState.followed.isEmpty, isTrue);
    });
  });
}
