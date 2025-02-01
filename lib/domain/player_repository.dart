import 'dart:convert';
import 'dart:io';

import 'package:dart_score/domain/player.dart';
import 'package:dart_score/global.dart';

class PlayerRepository {
  static File get _storageFile {
    final file = File("${Global.dataPath}/players.json");
    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync(json.encode([]));
    }
    return file;
  }

  static List<Player> getAllPlayers() {
    return _read();
  }

  static void addPlayer(Player player) {
    final players = _read();
    players.add(player);
    _write(players);
  }

  static Player? getPlayerById(String id) {
    final players = _read();
    return players.where((it) => it.id == id).elementAtOrNull(0);
  }

  static void removePlayer(String id) {
    var players = _read();
    players = players.where((it) => it.id != id).toList();
    _write(players);
  }

  static void _write(List<Player> matches) {
    _storageFile.writeAsStringSync(
        json.encode(matches.map((it) => _playerToJson(it)).toList()));
  }

  static List<Player> _read() {
    final List<dynamic> matches =
        json.decode(_storageFile.readAsStringSync());
    return matches.map((it) => _playerFromJson(it)).toList();
  }

  static Map<String, dynamic> _playerToJson(Player match) {
    return {
      'id': match.id,
      'name': match.name,
    };
  }

  static Player _playerFromJson(Map<String, dynamic> player) {
    return Player(
      player["id"],
      player["name"],
    );
  }
}
