import 'dart:math';

class EloCalculator {
  static int ratingChange(int winnerPoints, int looserPoints) {
    final int minPoints = 5;
    final int maxPoints = 35;
    final int midPoints = 15;

    int diff = looserPoints - winnerPoints;
    int gain = ((0.000125 * diff * diff) + (0.075 * diff) + midPoints).ceil();
    gain = max(minPoints, gain);
    gain = min(maxPoints, gain);
    return gain;
  }
}
