import 'dart:io';

import 'package:dart_score/dart_score.dart';
import 'package:dart_score/global.dart';

void main(List<String> arguments) {
  final String? dataPath = Platform.environment["DATA_PATH"];
  if (dataPath == null) {
    throw "'DATA_PATH' not set";
  }
  String? domain;
  if (arguments.isEmpty) {
    domain = "localhost";
  } else {
    domain = arguments[0];
  }
  Global.dataPath = dataPath;
  Global.domain = domain;
  run();
}
