import 'package:flame/components.dart';

import '../../river_warrior.dart';
import '../pages/play.dart';
import 'outlined_text.dart';

class Scoreboard extends PositionComponent
    with ParentIsA<PlayPage>, HasGameReference<RiverWarrior> {
  late final OutlinedText currentScoreText, highScoreText;

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
    highScoreText.text = 'BEST: ${game.highScore}';
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
    if (parent.score > game.highScore) game.highScore = parent.score;
  }
}
