import 'dart:ui';

import 'package:flame/components.dart';

import 'outlined_text.dart';

class Countdown extends OutlinedText {
  final VoidCallback? onCompleted;

  Countdown({this.onCompleted}) : super(anchor: Anchor.center);

  final countdown = Timer(2);

  @override
  void update(double dt) {
    super.update(dt);
    countdown.update(dt);
    text = countdown.current.toInt() > 0 ? 'Go!!' : 'Ready';
    if (countdown.finished) removeFromParent();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = size / 2;
  }

  @override
  void onRemove() {
    super.onRemove();
    onCompleted?.call();
  }
}
