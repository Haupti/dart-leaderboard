import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/match_repository.dart';
import 'package:dart_score/domain/player_repository.dart';

Html componentMatches() {
  return Html("""
<h1> Match-History </h1>
<table style="margin-top: 8px;">
  <tr>
    <th>Winner</th>
    <th>Looser</th>
    <th>Points</th>
    <th>Date</th>
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

List<({String winner, String looser, int points, String timestamp})>
    getMatchData() {
  final matches = MatchRepository.getAllMatches();
  List<({String winner, String looser, int points, String timestamp})>
      matchData = [];

  for (final match in matches) {
    final winnerName = PlayerRepository.getPlayerById(match.winnerId)?.name;
    final looserName = PlayerRepository.getPlayerById(match.looserId)?.name;
    matchData.add((
      winner: winnerName ?? "&#42;deleted&#42;",
      looser: looserName ?? "&#42;deleted&#42;",
      points: match.points,
      timestamp: match.timestamp
    ));
  }
  return matchData.reversed.toList();
}
