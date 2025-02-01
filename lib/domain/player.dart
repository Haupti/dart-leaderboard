import 'dart:math';

class Player {
  final String id;
  final String name;
  Player(this.id, this.name);
  Player.create(this.name)
      : id =
            "player-${Random().nextInt(999999999)}-${DateTime.now().millisecondsSinceEpoch}";
}
