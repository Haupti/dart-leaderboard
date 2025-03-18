import 'dart:collection';

class FormData {
  final HashMap<String, String> parsed;
  FormData(String raw) : parsed = FormData.parse(raw);

  String? getStringValueOrNull(String valueName) {
    return parsed[valueName];
  }

  static HashMap<String, String> parse(String raw) {
    final Iterable<List<String>> pairs =
        raw.split("&").map((it) => it.split("="));
    final HashMap<String, String> dataParsed = HashMap.from({});
    for (final pair in pairs) {
      if (pair.length != 2) {
        return dataParsed;
      }
      dataParsed[pair[0]] = pair[1];
    }
    return dataParsed;
  }
}
