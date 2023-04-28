import 'package:app/model/team.dart';
import 'package:app/states/followed_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Equipas Seguidas', () {
    Team team = Team(id: 0, name: 'team', logo: 'teamLogo');

    test('Sem equipas seguidas', () async {
      FollowedState followedState = FollowedState();
      expect(followedState.followed.isEmpty, isTrue);
    });

    test('Seguir equipa', () async {
      FollowedState followedState = FollowedState();
      followedState.toggleTeam(team);
      expect(followedState.followed.length, 1);
      expect(followedState.followed[0], team);
    });

    test('Deixar de seguir equipa', () async {
      FollowedState followedState = FollowedState();
      followedState.toggleTeam(team);
      followedState.toggleTeam(team);
      expect(followedState.followed.isEmpty, isTrue);
    });
  });
}
