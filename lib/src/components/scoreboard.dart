import 'package:flame/components.dart';

import '../pages/game.dart';
import 'outlined_text.dart';

class Scoreboard extends PositionComponent with ParentIsA<GamePage> {
  late final OutlinedText currentScoreText, highScoreText;
  int highScore = 0;

  @override
  void onLoad() {
    super.onLoad();
    addAll([
      currentScoreText = OutlinedText(),
      highScoreText = OutlinedText(scale: Vector2.all(0.5)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    currentScoreText.text = '${parent.score}';
    highScoreText.text = 'BEST: $highScore';
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    currentScoreText.position = Vector2(size.y / 20, 0);
    highScoreText.position = Vector2(size.y / 20, currentScoreText.size.y);
  }

  @override
  void onRemove() {
    super.onRemove();
    if (parent.score > highScore) highScore = parent.score;
  }
}
