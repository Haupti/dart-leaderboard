import 'dart:convert';
import 'dart:io';

import 'package:dart_score/domain/dart_match.dart';
import 'package:dart_score/global.dart';

class MatchRepository {
  static File get _storageFile {
    final file = File("${Global.dataPath}/matches.json");
    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync(json.encode([]));
    }
    return file;
  }

  static void addMatch(DartMatch match) {
    final matches = _read();
    matches.add(match);
    _write(matches);
  }

  static List<DartMatch> getAllMatches() {
    return _read();
  }

  static void _write(List<DartMatch> matches) {
    _storageFile.writeAsStringSync(
        json.encode(matches.map((it) => _matchToJson(it)).toList()));
  }

  static List<DartMatch> _read() {
    final List<dynamic> matches = json.decode(_storageFile.readAsStringSync());
    return matches.map((it) => _matchFromJson(it)).toList();
  }

  static Map<String, dynamic> _matchToJson(DartMatch match) {
    return {
      'id': match.id,
      'winnerId': match.winnerId,
      'looserId': match.looserId,
      'points': match.points,
      'timestamp': match.timestamp,
    };
  }

  static DartMatch _matchFromJson(Map<String, dynamic> match) {
    return DartMatch(
      match["id"],
      match["winnerId"],
      match["looserId"],
      match["points"],
      match["timestamp"],
    );
  }
}
