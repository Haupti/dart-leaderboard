import 'package:dart_score/domain/elo_calculator.dart';
import 'package:test/test.dart';

void main() {
  test('winner has more points', () {
    expect(EloCalculator.ratingChange(800, 600), 5);
    expect(EloCalculator.ratingChange(800, 650), 7);
    expect(EloCalculator.ratingChange(800, 700), 9);
    expect(EloCalculator.ratingChange(800, 750), 12);
    expect(EloCalculator.ratingChange(800, 800), 15);
  });
  test('looser has more points', () {
    expect(EloCalculator.ratingChange(600, 800), 35);
    expect(EloCalculator.ratingChange(650, 800), 30);
    expect(EloCalculator.ratingChange(700, 800), 24);
    expect(EloCalculator.ratingChange(750, 800), 20);
    expect(EloCalculator.ratingChange(800, 800), 15);
  });
}
