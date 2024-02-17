import 'package:flame/components.dart';

import '../../river_warrior.dart';
import '../pages/game.dart';

enum CrossState { red, grey }

class Cross extends SpriteGroupComponent<CrossState>
    with ParentIsA<GamePage>, HasGameReference<RiverWarrior> {
  final int count;

  Cross(
      {required this.count,
      super.position,
      super.size,
      super.scale,
      super.anchor,
      super.priority});

  @override
  void onLoad() {
    super.onLoad();
    sprites = {
      CrossState.red: Sprite(game.images.fromCache('red cross.png')),
      CrossState.grey: Sprite(game.images.fromCache('grey cross.png')),
    };
    current = CrossState.red;
  }

  @override
  void update(double dt) {
    super.update(dt);
    current = parent.mistake <= count ? CrossState.grey : CrossState.red;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = Vector2.all(size.y / 10);
    position = Vector2(
        size.x - this.size.x * (game.maxMistake - count) - this.size.x / 2,
        this.size.y / 2);
  }
}
