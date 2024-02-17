import 'package:flame/components.dart';

import 'outlined_text.dart';

class Countdown extends OutlinedText {
  Countdown() : super(anchor: Anchor.center);

  double countdown = 2;

  @override
  void update(double dt) {
    super.update(dt);
    countdown -= dt;
    text = countdown.toInt() == 0 ? 'Go!!' : 'Ready';
    if (countdown <= 0) removeFromParent();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = size / 2;
  }
}
