import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/player_repository.dart';

Html componentAddMatch() {
  return Html("""
<h1>Add Match Results</h1>
<form hx-post="/api/add-match" hx-swap="outerHTML" hx-target="#addMatchToast">
  <label for="winner">
    Winner:
    <select style="width: 100%;" name="winner-id" id="winner" type="select" value="Winner">
      <option value="--">--</option>
      ${PlayerRepository.getAllPlayers().map((it) => """<option value="${it.id}">${it.name}</option>""").join("\n")}
    </select>
  </label>
  <label for="looser">
    Looser:
    <select style="width: 100%;" name="looser-id" id="looser" type="select" value="Looser">
      <option value="--">--</option>
      ${PlayerRepository.getAllPlayers().map((it) => """<option value="${it.id}">${it.name}</option>""").join("\n")}
    </select>
  </label>
  <input style="margin: 8px 0 0 0;" type="submit" value="Submit"/>
</form>
<div id="addMatchToast"></div>
""");
}

Html componentMatchAddSuccessToast() {
  return Html("""
    <div class="fadeout" style="margin-top: 8px; padding: 4px 8px; background-color: yellowgreen; color: white; border-radius: 4px;" id="addMatchToast">
      <p> Success! </p>
    </div>
    """);
}

Html componentMatchAddFailedToast(String message) {
  return Html("""
    <div class="fadeout" style="margin-top: 8px; padding: 4px 8px; background-color: tomato; color: white; border-radius: 4px;" id="addMatchToast">
      <p> $message </p>
    </div>
    """);
}
