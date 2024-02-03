import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Button extends PositionComponent with HasGameReference, TapCallbacks {
  final int id;
  final VoidCallback? onPressed;
  final double scaleFactor;

  Button(
      {required this.id,
      this.onPressed,
      this.scaleFactor = 0.95,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.priority})
      : super(anchor: Anchor.center);

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
}
