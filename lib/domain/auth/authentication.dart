import 'dart:io';

import 'package:dart_score/domain/auth/cookie_data.dart';
import 'package:dart_score/domain/auth/user_repository.dart';

enum Level {
  user,
  admin;

  static Level? fromString(String value) {
    switch (value) {
      case "user":
        return Level.user;
      case "admin":
        return Level.admin;
      default:
        return null;
    }
  }
}

class Authentication {
  Level level;
  Authentication(this.level);

  static Authentication? from(HttpHeaders headers) {
    final cookie = headers.value("Cookie");
    if (cookie == null) {
      return null;
    }
    final cookieData = CookieData(cookie);
    final username = cookieData.getStringValueOrNull("username");
    final password = cookieData.getStringValueOrNull("password");
    if (username == null || password == null) {
      return null;
    }
    final user = UserRepository.getUserOrNull("$username:$password");
    if (user == null) {
      return null;
    }
    return Authentication(
      user.level,
    );
  }

  static Authentication? fromAuthString(String authString) {
    final level = UserRepository.getUserOrNull(authString)?.level;
    if (level == null) {
      return null;
    }
    return Authentication(level);
  }
}
