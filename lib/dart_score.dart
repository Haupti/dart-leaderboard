import 'dart:convert';
import 'dart:io';

import 'package:dart_score/components/add_match.dart';
import 'package:dart_score/components/base.dart';
import 'package:dart_score/components/login_page.dart';
import 'package:dart_score/components/manage_player.dart';
import 'package:dart_score/components/matches.dart';
import 'package:dart_score/components/ranking.dart';
import 'package:dart_score/components/utils.dart';
import 'package:dart_score/domain/api_service.dart';
import 'package:dart_score/domain/auth/authentication.dart';
import 'package:dart_score/domain/form_data.dart';
import 'package:dart_score/domain/utils.dart';
import 'package:dart_score/global.dart';

void run() async {
  var server = await HttpServer.bind(InternetAddress.anyIPv6, 8084);
  await for (HttpRequest request in server) {
    Authentication? auth = Authentication.from(request.headers);
    switch ((request.method, request.uri.path)) {
      case ("POST", "/api/login"):
        auth = await handleLogin(request);
        continue;
    }

    if (auth == null) {
      request.respond(ServerResponse.html(
        rootPage(componentLoginPage()).render(),
      ));
      continue;
    }
    await handleRequest(request, auth);
  }
}

Future<Authentication?> handleLogin(HttpRequest request) async {
  String content = await utf8.decodeStream(request);
  final data = FormData(content);
  final username = data.getStringValueOrNull("username");
  final password = data.getStringValueOrNull("password");
  if (username == null || password == null) {
    return null;
  }
  final auth = Authentication.fromAuthString("$username:$password");
  if (auth != null) {
    request.response.statusCode = 200;
    request.response.headers.add("Set-Cookie",
        "username=$username; Domain=${Global.domain}; ${Global.domain == "localhost" ? "" : "Secure"}; Path=/; HttpOnly");
    request.response.headers.add("Set-Cookie",
        "password=$password; Domain=${Global.domain}; ${Global.domain == "localhost" ? "" : "Secure"}; Path=/; HttpOnly");
    request.response.headers.add("HX-Refresh", "true");
  } else {
    request.response.statusCode = 403;
  }
  request.response.close();
  return auth;
}

Future<void> handleRequest(HttpRequest request, Authentication auth) async {
  switch ((request.method, request.uri.path)) {
    case ("GET", "/"):
      request.respond(ServerResponse.html(
        basePage(componentRanking(), auth).render(),
      ));
      break;
    case ("GET", "/manage-players"):
      request.respond(ServerResponse.html(
        basePage(componentManagePlayers(), auth).render(),
      ));
      break;
    case ("GET", "/add-match"):
      request.respond(ServerResponse.html(
        basePage(componentAddMatch(), auth).render(),
      ));
      break;
    case ("GET", "/matches"):
      request.respond(ServerResponse.html(
        basePage(componentMatches(), auth).render(),
      ));
      break;
    case ("POST", "/api/add-player"):
      final status = await ApiService.addPlayer(request, auth);
      if (status is NotAllowed) {
        request.forbidden();
      } else {
        request.respond(ServerResponse.html(
          componentPlayerPagePlayerList().render(),
        ));
      }
      break;
    case ("POST", "/api/delete-player"):
      final Status status = await ApiService.deletePlayer(request, auth);
      if (status is NotAllowed) {
        request.forbidden();
      } else if (status is Failure) {
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
    response.statusCode = 500;
    response.close();
  }

  void forbidden() {
    response.statusCode = 403;
    response.close();
  }
}
