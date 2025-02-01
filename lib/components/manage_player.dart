import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/player_repository.dart';

Html componentManagePlayers() {
  return Html("""
<h1>Manage Player</h1>
<h2> Add Player </h2>
<form style="display: block;" hx-post="/api/add-player" hx-swap="outerHTML" hx-target="#addPlayerPagePlayerList" hx-on::after-request="this.reset(); alert("Success!");">
  <label for="player-name-input">
    Name:
    <input id="player-name-input" type="text" name="player-name"/>
  </label>
  <input style="margin: 8px 0;" type="submit" value="Submit"/>
</form>
<h2> All Players </h2>
${componentPlayerPagePlayerList().render()}
""");
}

Html componentPlayerPagePlayerList() {
  return Html("""
<div id="addPlayerPagePlayerList">
${PlayerRepository.getAllPlayers().map((it) => """
<div id="player-listing-${it.id}" style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px; max-height: 30px;"> 
  <button
    hx-trigger="click"
    hx-post="/api/delete-player"
    hx-vals='{"player-id": "${it.id}"}'
    hx-swap="outerHTML"
    hx-target="#player-listing-${it.id}"
  >
    &#128465;
  </button>
  <p><strong>${it.name}</strong></p>
</div>
""").join("\n")}
</div>""");
}
