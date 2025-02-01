import 'dart:io';

import 'package:dart_score/dart_score.dart';
import 'package:dart_score/global.dart';

void main(List<String> arguments) {
  final String? dataPath = Platform.environment["DATA_PATH"];
  if (dataPath == null) {
    throw "'DATA_PATH' not set";
  }
  Global.dataPath = dataPath;
  run();
}
