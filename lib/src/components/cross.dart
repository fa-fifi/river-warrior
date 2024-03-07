import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/pages/play.dart';

enum CrossState { red, grey }

class Cross extends SpriteGroupComponent<CrossState>
    with ParentIsA<PlayPage>, HasGameReference<RiverWarrior> {
  final int count;

  Cross(
      {required this.count,
      super.position,
      super.size,
      super.scale,
      super.priority})
      : super(anchor: Anchor.center);

  @override
  void onLoad() {
    super.onLoad();
    sprites = {
      CrossState.red: Sprite(game.images.fromCache('others/red_cross.png')),
      CrossState.grey: Sprite(game.images.fromCache('others/grey_cross.png')),
    };
    current = CrossState.red;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final previous = current;
    current = game.mistake <= count ? CrossState.grey : CrossState.red;
    if (previous == current) return;
    add(ScaleEffect.by(
        Vector2.all(1.2), EffectController(duration: 0.3, alternate: true)));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = Vector2.all(size.y / 10);
    position =
        Vector2(size.x - this.size.x * (game.maxMistake - count), this.size.y);
  }
}
