import 'package:flame/components.dart';

import '../../river_warrior.dart';
import '../pages/game.dart';

enum CrossState { red, grey }

class CrossComponent extends SpriteGroupComponent<CrossState>
    with ParentIsA<GamePage>, HasGameReference<RiverWarrior> {
  final int count;

  CrossComponent(
      {required this.count,
      super.position,
      super.size,
      super.scale,
      super.angle,
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
    current = parent.mistakeCount <= count ? CrossState.grey : CrossState.red;
  }
}
