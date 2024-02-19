import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart' as composition;
import 'package:flutter/material.dart';

import '../../river_warrior.dart';
import '../models/item.dart';
import '../models/plastic.dart';
import '../models/rock.dart';
import '../pages/game.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class Throwable extends SpriteComponent
    with ParentIsA<GamePage>, HasGameReference<RiverWarrior> {
  final Item item;
  Vector2 velocity;
  bool divided;

  Throwable(super.image,
      {required this.item,
      required this.velocity,
      this.divided = false,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor = Anchor.center})
      : super.fromImage();

  void finish() {
    game.router.pushNamed('game-over');
    parent.isReleased = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += .5 * dt;
    angle %= 2 * pi;

    position +=
        Vector2(velocity.x, -(velocity.y * dt - .5 * gravity * dt * dt));

    velocity.y += (acceleration + gravity) * dt;

    if ((position.y - size.y) > game.size.y) {
      removeFromParent();
      if (!divided && item is Plastic) {
        parent.mistake++;
        if (parent.mistake >= game.maxMistake) finish();
      }
    }
  }

  void touchAtPoint(Vector2 vector2) {
    if (divided) return;
    if (item is Rock) return finish();
    divided = true;
    removeFromParent();
    parent.score += item.point;

    final a = getSliceAngle(center: center, initAngle: angle, touch: vector2);

    if (a < 45 || (a > 135 && a < 225) || a > 315) {
      final dividedImage1 = composition.ImageComposition()
            ..add(sprite!.image, Vector2(0, 0),
                source: Rect.fromLTWH(0, 0, sprite!.image.width.toDouble(),
                    sprite!.image.height / 2)),
          dividedImage2 = composition.ImageComposition()
            ..add(sprite!.image, Vector2(0, 0),
                source: Rect.fromLTWH(0, sprite!.image.height / 2,
                    sprite!.image.width.toDouble(), sprite!.image.height / 2));

      parent.addAll([
        Throwable(dividedImage2.composeSync(),
            item: item,
            velocity: Vector2(velocity.x - 1, velocity.y),
            divided: true,
            position: center -
                Vector2(size.x / 2 * cos(angle), size.x / 2 * sin(angle)),
            size: Vector2(size.x, size.y / 2),
            scale: scale,
            angle: angle,
            anchor: Anchor.topLeft),
        Throwable(dividedImage1.composeSync(),
            item: item,
            velocity: Vector2(velocity.x + 1, velocity.y),
            divided: true,
            position: center +
                Vector2(size.x / 4 * cos(angle + 3 * pi / 2),
                    size.x / 4 * sin(angle + 3 * pi / 2)),
            size: Vector2(size.x, size.y / 2),
            scale: scale,
            angle: angle)
      ]);
    } else {
      final dividedImage1 = composition.ImageComposition()
            ..add(sprite!.image, Vector2(0, 0),
                source: Rect.fromLTWH(0, 0, sprite!.image.width / 2,
                    sprite!.image.height.toDouble())),
          dividedImage2 = composition.ImageComposition()
            ..add(sprite!.image, Vector2(0, 0),
                source: Rect.fromLTWH(sprite!.image.width / 2, 0,
                    sprite!.image.width / 2, sprite!.image.height.toDouble()));

      parent.addAll([
        Throwable(dividedImage1.composeSync(),
            item: item,
            velocity: Vector2(velocity.x - 1, velocity.y),
            divided: true,
            position: center -
                Vector2(size.x / 4 * cos(angle), size.x / 4 * sin(angle)),
            size: Vector2(size.x / 2, size.y),
            scale: scale,
            angle: angle),
        Throwable(dividedImage2.composeSync(),
            item: item,
            velocity: Vector2(velocity.x + 1, velocity.y),
            divided: true,
            position: center +
                Vector2(size.x / 2 * cos(angle + 3 * pi / 2),
                    size.x / 2 * sin(angle + 3 * pi / 2)),
            size: Vector2(size.x / 2, size.y),
            scale: scale,
            angle: angle,
            anchor: Anchor.topLeft)
      ]);
    }
  }
}
