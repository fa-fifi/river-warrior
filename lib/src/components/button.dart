import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../river_warrior.dart';

class Button extends PositionComponent
    with HasGameReference<RiverWarrior>, TapCallbacks {
  final int id;
  final VoidCallback? onPressed;

  Button(
      {required this.id,
      this.onPressed,
      super.position,
      super.scale,
      super.angle,
      super.priority})
      : super(anchor: Anchor.center);

  final double scaleFactor = 0.95;

  @override
  @mustCallSuper
  void onMount() {
    final sheet = SpriteSheet.fromColumnsAndRows(
        image: game.images.fromCache('buttons.png'), columns: 3, rows: 3);

    add(SpriteComponent(sprite: sheet.getSpriteById(id), size: size));
    super.onMount();
  }

  @override
  @mustCallSuper
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(scaleFactor);
    super.onTapDown(event);
  }

  @override
  @mustCallSuper
  void onTapUp(TapUpEvent event) {
    scale = Vector2.all(1 / scaleFactor);
    onPressed?.call();
    super.onTapUp(event);
  }

  @override
  @mustCallSuper
  void onTapCancel(TapCancelEvent event) {
    scale = Vector2.all(1 / scaleFactor);
    super.onTapCancel(event);
  }

  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2.all((size.y / 100).roundToDouble() * 10);
    children
        .whereType<SpriteComponent>()
        .forEach((component) => component.size = this.size);
    super.onGameResize(size);
  }
}
