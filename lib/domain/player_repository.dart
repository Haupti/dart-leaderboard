import 'package:dart_score/domain/player.dart';

class PlayerRepository {
  static List<Player> players = [Player.create("steve"), Player.create("tom")];
  static List<Player> getAllPlayers() {
    return players;
  }

  static void addPlayer(Player player) {
    players.add(player);
  }

  static Player? getPlayerById(String id) {
    return players.where((it) => it.id == id).elementAtOrNull(0);
  }

  static void removePlayer(String id) {
    players = players.where((it) => it.id != id).toList();
  }
}
