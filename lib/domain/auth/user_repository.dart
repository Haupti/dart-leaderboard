import 'dart:collection';
import 'dart:io';
import 'package:dart_score/domain/auth/authentication.dart';
import 'package:dart_score/global.dart';

class User {
  Level level;
  User(this.level);
}

class UserRepository {
  static File get _storageFile {
    final file = File("${Global.dataPath}/users");
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  static User? getUserOrNull(String authString) {
    final users = HashMap.from(_load());
    return users[authString];
  }

  static Map<String, User> _load() {
    String fileContent = _storageFile.readAsStringSync();
    List<String> lines =
        fileContent.split("\n").where((it) => it.trim() != "").toList();
    Map<String, User> users = Map.from({});
    for (final line in lines) {
      List<String> parts = line.split(", ");
      users[parts[1]] = User(
        Level.fromString(parts[0])!,
      );
    }
    return users;
  }
}
