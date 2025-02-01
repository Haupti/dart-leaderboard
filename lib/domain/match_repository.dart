import 'package:dart_score/domain/dart_match.dart';

class MatchRepository {
  static List<DartMatch> matches = [];
  static List<DartMatch> getAllPlayers() {
    return matches;
  }

  static void addMatch(DartMatch match) {
    matches.add(match);
  }

  static List<DartMatch> getAllMatches() {
    return matches;
  }
}
