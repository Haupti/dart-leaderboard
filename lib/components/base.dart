import 'package:dart_score/components/html.dart';
import 'package:dart_score/components/utils.dart';
import 'package:dart_score/domain/auth/authentication.dart';

Html basePage(Html main, Authentication? auth) {
  return rootPage(Html("""
<nav style="display: flex; flex-wrap: wrap; gap: 8px; align-items: center;">
  <p style="font-size: 36px; margin: 0 8px 0 0;"><strong>&#127919;</strong></p>
  <a href="/"> Leaderboard </a>
  <a href="/matches"> Matches </a>
  <a href="/add-match"> Add Match </a>
  ${Html("""<a href="/manage-players"> Manage Players </a>""").adminOnly(auth)}
</nav>
<main>
  ${main.render()}
</main>"""));
}

Html rootPage(Html body) {
  return Html("""
<!DOCTYPE html>
<html>
  <head>
    <script src="https://unpkg.com/htmx.org@2.0.4"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      body {
        font-family: "Arial", sans-serif;
        max-width: 90ch;
        padding: 8px 5ch;
        margin: auto;
      }
      nav > a {
        border-radius: 4px;
        padding: 8px;
        text-decoration: none;
        background-color: #eeeeee;
        color: black;
      }
      nav > a:visited {
        color: black;
      }

      .fadeout {
        animation: fadeOut 3s forwards;
      }
      @keyframes fadeOut {
        from {
          opacity: 1;
        }
        99% {
          opacity: 1;
        }
        to {
          opacity: 0; 
          display: none;
        }
      }

      table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        table-layout: fixed;
      }

      th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }

      th {
        background-color: #f2f2f2;
        font-weight: bold;
      }

      tr:last-child td {
        border-bottom: none;
      }

      tr:hover {
        background-color: #f5f5f5;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      select, input[type="text"], input[type="password"] {
        border-radius: 5px;
        background-color: white;
        border: 2px solid #dddddd;
        padding: 4px;
      }
      select:hover, input[type="text"], input[type="password"] {
        border: 2px solid #cccccc;
        cursor: pointer;
      }

      button, input[type="submit"] {
        border-radius: 5px;
        border: none;
        padding: 8px;
        background-color: #dddddd;
        color: black;
      }

      button:hover, input[type="submit"]:hover {
        background-color: #cccccc;
        cursor: pointer;
      }

    </style>
  </head> 
  <body>
    ${body.render()}
  </body>
</html>
""");
}
