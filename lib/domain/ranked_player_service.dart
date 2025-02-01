import 'dart:collection';

import 'package:dart_score/domain/match_repository.dart';
import 'package:dart_score/domain/player_repository.dart';

class RankedPlayerService {
  static List<RankedPlayer> getSortedRankedPlayers() {
    final matches = MatchRepository.getAllMatches();
    final players = PlayerRepository.getAllPlayers();

    Map<String, RankedPlayer> idToPlayer = {};
    for (final it in players) {
      idToPlayer[it.id] = RankedPlayer(it.id, it.name, 0, 0);
    }

    for (final match in matches) {
      final winner = idToPlayer[match.winnerId];
      if (winner != null) {
        winner.wins += 1;
        winner.total += 1;
        winner.points += match.points;
        idToPlayer[winner.id] = winner;
      }
      final looser = idToPlayer[match.looserId];
      if (looser != null) {
        looser.total += 1;
        looser.points -= match.points;
        idToPlayer[looser.id] = looser;
      }
    }

    List<RankedPlayer> matchData = idToPlayer.values.toList();
    matchData.sort((a, b) => a.points > b.points ? 0 : 1);
    return matchData.toList();
  }

  static HashMap<String, RankedPlayer> getRankedPlayersById() {
    final List<RankedPlayer> players = getSortedRankedPlayers();
    HashMap<String, RankedPlayer> map = HashMap.from({});
    for (final player in players) {
      map[player.id] = player;
    }
    return map;
  }
}

class RankedPlayer {
  final String id;
  final String name;
  int points = 800;
  int wins;
  int total;
  RankedPlayer(this.id, this.name, this.wins, this.total);
}
