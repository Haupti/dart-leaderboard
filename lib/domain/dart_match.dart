import 'dart:math';

class DartMatch {
  final String id;
  final String winnerId;
  final String looserId;
  final int points;
  final String timestamp;

  DartMatch.create(
    this.winnerId,
    this.looserId,
    this.points,
    this.timestamp,
  ) : id = "match-${Random().nextInt(999999999)}-${DateTime.now().millisecondsSinceEpoch}";

  DartMatch(
    this.id,
    this.winnerId,
    this.looserId,
    this.points,
    this.timestamp,
  );
}
