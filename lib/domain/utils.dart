sealed class Status {}

class Success implements Status {}

class Failure implements Status {
  final String reason;
  Failure(this.reason);
}

class NotAllowed implements Status {}

