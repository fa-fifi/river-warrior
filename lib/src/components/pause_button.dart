import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:river_warrior/river_warrior.dart';
import 'simple_button.dart';

class PauseButton extends SimpleButton with HasGameReference<RiverWarrior> {
  PauseButton({VoidCallback? onPressed})
      : super(
          Path()
            ..moveTo(14, 10)
            ..lineTo(14, 30)
            ..moveTo(26, 10)
            ..lineTo(26, 30),
          position: Vector2(60, 10),
        ) {
    super.action = onPressed ?? () => game.router.pushNamed('pause');
  }
}
