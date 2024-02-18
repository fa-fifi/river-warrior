import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../river_warrior.dart';

final class Button extends PositionComponent
    with HasGameReference<RiverWarrior>, TapCallbacks {
  final int id;
  final VoidCallback? onPressed;
  final double scaleFactor;

  Button(
      {required this.id,
      this.onPressed,
      this.scaleFactor = 0.95,
      super.position,
      super.scale,
      super.angle,
      super.priority})
      : super(anchor: Anchor.center);

  late final SpriteComponent sprite;

  @override
  void onLoad() {
    super.onLoad();
    final sheet = SpriteSheet.fromColumnsAndRows(
        image: game.images.fromCache('buttons.png'), columns: 3, rows: 3);
    add(sprite = SpriteComponent(sprite: sheet.getSpriteById(id), size: size));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    scale = Vector2.all(scaleFactor);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    scale = Vector2.all(1 / scaleFactor);
    onPressed?.call();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    scale = Vector2.all(1 / scaleFactor);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = Vector2.all(size.y / 10);
    sprite.size = this.size;
  }
}
