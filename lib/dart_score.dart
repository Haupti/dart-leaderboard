import 'dart:io';

import 'package:dart_score/components/add_match.dart';
import 'package:dart_score/components/base.dart';
import 'package:dart_score/components/manage_player.dart';
import 'package:dart_score/components/matches.dart';
import 'package:dart_score/components/ranking.dart';
import 'package:dart_score/components/utils.dart';
import 'package:dart_score/domain/api_service.dart';
import 'package:dart_score/domain/utils.dart';

void run() async {
  var server = await HttpServer.bind(InternetAddress.anyIPv6, 3000);
  await for (HttpRequest request in server) {
    switch ((request.method, request.uri.path)) {
      case ("GET", "/"):
        request.respond(ServerResponse.html(
          basePage(componentRanking()).render(),
        ));
        break;
      case ("GET", "/manage-players"):
        request.respond(ServerResponse.html(
          basePage(componentManagePlayers()).render(),
        ));
        break;
      case ("GET", "/add-match"):
        request.respond(ServerResponse.html(
          basePage(componentAddMatch()).render(),
        ));
        break;
      case ("GET", "/matches"):
        request.respond(ServerResponse.html(
          basePage(componentMatches()).render(),
        ));
        break;
      case ("POST", "/api/add-player"):
        await ApiService.addPlayer(request);
        request.respond(ServerResponse.html(
          componentPlayerPagePlayerList().render(),
        ));
        break;
      case ("POST", "/api/delete-player"):
        final Status status = await ApiService.deletePlayer(request);
        if (status is Failure) {
          request.error(status.reason);
        } else {
          request.respond(ServerResponse.html(
            emptyComponent().render(),
          ));
        }
        break;
      case ("POST", "/api/add-match"):
        final failMessage = await ApiService.addMatch(request);
        if (failMessage == null) {
          request.respond(ServerResponse.html(
            componentMatchAddSuccessToast().render(),
          ));
        } else {
          request.respond(ServerResponse.html(
            componentMatchAddFailedToast(failMessage).render(),
          ));
        }
        break;
      default:
        request.respond(ServerResponse.notFound());
    }
  }
}

class ServerResponse {
  int status = 200;
  String contentType;
  String body;
  ServerResponse(this.body, this.contentType);

  static ServerResponse notFound() {
    var r = ServerResponse("<h1> 404 </h1>", "text/html");
    r.status = 404;
    return r;
  }

  static ServerResponse html(String html) {
    var r = ServerResponse(html, "text/html");
    return r;
  }
}

extension Respond on HttpRequest {
  void respond(ServerResponse response) {
    this.response.headers.add("Content-Type", response.contentType);
    this.response.statusCode = response.status;
    this.response.write(response.body);
    this.response.close();
  }

  void error(String reason) {
    response.headers.add("Content-Type", "text/plain");
    response.statusCode = 500;
    response.close();
  }
}
