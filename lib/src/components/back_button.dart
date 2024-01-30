import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import '../../river_warrior.dart';
import 'simple_button.dart';

class BackButton extends SimpleButton with HasGameReference<RiverWarrior> {
  BackButton({VoidCallback? onPressed})
      : super(
          Path()
            ..moveTo(22, 8)
            ..lineTo(10, 20)
            ..lineTo(22, 32)
            ..moveTo(12, 20)
            ..lineTo(34, 20),
          position: Vector2.all(10),
        ) {
    super.action = onPressed ?? () => game.router.pop();
  }
}
