import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/player_repository.dart';

Html componentAddPlayer() {
  return Html("""
<h1>Add Player</h1>
<form style="display: block;" hx-post="/api/add-player" hx-swap="outerHTML" hx-target="#addPlayerPagePlayerList" hx-on::after-request="this.reset(); alert("Success!");">
  <label for="player-name-input">
    Name:
    <input id="player-name-input" type="text" name="player-name"/>
  </label>
  <input style="margin: 8px 0;" type="submit" value="Submit"/>
</form>
${componentPlayerPagePlayerList().render()}
""");
}

Html componentPlayerPagePlayerList() {
  return Html("""
<div id="addPlayerPagePlayerList">
  <ul>
    ${PlayerRepository.getAllPlayers().map((it) => "<li> ${it.name} </li>").join("\n")}
  </ul>
</div>""");
}
