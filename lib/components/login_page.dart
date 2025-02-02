import 'package:dart_score/components/html.dart';

Html componentLoginPage() {
  return Html("""
<h1> &#127919; Login </h1>
<form style="display: grid; gap: 8px;" hx-post="/api/login" hx-swap="none">
    <label for="username-input"> Name: </label>
    <input id="username-input" type="text" name="username"/>
    <label for="password-input"> Password: </label>
    <input id="password-input" type="password" name="password"/>
    <input type="submit">Submit</input>
</form>
""");
}
