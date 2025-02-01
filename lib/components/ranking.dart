import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/match_repository.dart';
import 'package:dart_score/domain/player_repository.dart';

Html componentRanking() {
  return Html("""
<h1> Leaderboard </h1>
<table style="margin-top: 8px;">
  <tr>
    <th>Position</th>
    <th>Name</th>
    <th>Points</th>
    <th>Wins</th>
    <th>Total</th>
  </tr>
  ${getMatchData().map((it) => """
    <tr>
      <td>
        &#127942; ${it.winner}
      </td>
      <td>
        &#10060; ${it.looser}
      </td>
      <td>
        ${it.points}
      </td>
      <td>
        ${it.timestamp}
      </td>
    </tr>
    """).join("\n")}
</table>
""");
}

List<({String position, String name, int points, int wins, int total})>
    getRankData() {
  final matches = MatchRepository.getAllMatches();
  final players = PlayerRepository.getAllPlayers();
  List<({int position, String name, int points, int wins, int total})>
      matchData = [];

  Map<String, int> idToPoints = {};
  Map<String, int> idToWins = {};
  Map<String, int> idToTotal = {};

  for (final match in matches) {
  }
  final sortedPlayers = 
  for(final player in players){
    matchData.add((
      position: 1,
      name: "steve",
      points: 1,
      wins: 1,
      total: 1,
    ));
  }
  return matchData.reversed.toList();
}
