import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dart_score/domain/auth/authentication.dart';
import 'package:dart_score/domain/dart_match.dart';
import 'package:dart_score/domain/elo_calculator.dart';
import 'package:dart_score/domain/form_data.dart';
import 'package:dart_score/domain/match_repository.dart';
import 'package:dart_score/domain/player.dart';
import 'package:dart_score/domain/player_repository.dart';
import 'package:dart_score/domain/ranked_player_service.dart';
import 'package:dart_score/domain/utils.dart';

class ApiService {
  static Future<Status> addPlayer(
      HttpRequest request, Authentication auth) async {
    String content = await utf8.decodeStream(request);
    final data = FormData(content);
    final username = data.getStringValueOrNull("player-name");
    if (username == null) {
      return Failure("no user name");
    }
    PlayerRepository.addPlayer(Player.create(username));
    return Success();
  }

  static Future<Status> deletePlayer(
      HttpRequest request, Authentication auth) async {
    if (auth.level != Level.admin) {
      return NotAllowed();
    }
    String content = await utf8.decodeStream(request);
    final data = FormData(content);
    final id = data.getStringValueOrNull("player-id");
    if (id == null) {
      return Failure("invalid data");
    }
    PlayerRepository.removePlayer(id);
    return Success();
  }

  static Future<String?> addMatch(HttpRequest request) async {
    String content = await utf8.decodeStream(request);
    final data = FormData(content);
    final winnerId = data.getStringValueOrNull("winner-id");
    final looserId = data.getStringValueOrNull("looser-id");
    if (winnerId == null || looserId == null) {
      return "Invalid data, missing ids";
    }
    if (winnerId == "--" || looserId == "--") {
      return "Please select two players";
    }
    if (winnerId == looserId) {
      return "Players selected cannot be identical";
    }
    final HashMap<String, RankedPlayer> playerMap =
        RankedPlayerService.getRankedPlayersById();
    final gain = EloCalculator.ratingChange(
        playerMap[winnerId]!.points, playerMap[looserId]!.points);

    MatchRepository.addMatch(DartMatch.create(winnerId, looserId, gain,
        DateTime.now().toIso8601String().split("T")[0]));
    return null;
  }
}
