import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/ranked_player_service.dart';

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
  ${mapToTableRows(RankedPlayerService.getSortedRankedPlayers())}
</table>
""");
}

String mapToTableRows(List<RankedPlayer> players) {
  List<String> results = [];
  print("ITERATE OVER PLAYERs: ${players.length}");
  for (int i = 0; i < players.length; i++) {
    final player = players[i];
    results.add("""
<tr>
  <td>
    ${i + 1}.
  </td>
  <td>
    ${player.name}
  </td>
  <td>
    ${player.points}
  </td>
  <td>
    ${player.wins}
  </td>
  <td>
    ${player.total}
  </td>
</tr>
""");
  }
  return results.join("\n");
}
