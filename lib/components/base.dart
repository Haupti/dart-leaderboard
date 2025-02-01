import 'package:dart_score/components/html.dart';

Html basePage(Html main) {
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

    </style>
  </head> 
  <body>
    <nav style="display: flex; flex-wrap: wrap; gap: 8px; align-items: center;">
      <p style="font-size: 36px; margin: 0 8px 0 0;"><strong>&#127919;</strong></p>
      <a href="/"> Leaderboard </a>
      <a href="/matches"> Matches </a>
      <a href="/add-match"> Add Match </a>
      <a href="/add-player"> Add Player </a>
    </nav>
    <main>
      ${main.render()}
    </main>
  </body>
</html>
""");
}
