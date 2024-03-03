import 'package:flame/components.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/components/outlined_text.dart';

class Scoreboard extends PositionComponent with HasGameReference<RiverWarrior> {
  late final OutlinedText currentScoreText;
  late final OutlinedText highScoreText;

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
    currentScoreText.text = '${game.score}';
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
    if (game.score > game.highScore) game.highScore = game.score;
    game.mistake = 0;
    game.score = 0;
    game.tally.clear();
  }
}
