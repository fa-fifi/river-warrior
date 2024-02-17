import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart' as composition;
import 'package:flutter/material.dart';

import '../../river_warrior.dart';
import '../models/coin.dart';
import '../models/rock.dart';
import '../models/trash.dart';
import '../pages/game.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class Throwable extends SpriteComponent
    with ParentIsA<GamePage>, HasGameReference<RiverWarrior> {
  Vector2 velocity;
  final Trash trash;
  bool divided;

  Throwable(super.image,
      {super.position,
      super.size,
      required this.velocity,
      required this.trash,
      super.angle,
      super.anchor = Anchor.center,
      this.divided = false})
      : super.fromImage();

  @override
  void update(double dt) {
    super.update(dt);
    angle += .5 * dt;
    angle %= 2 * pi;

    position +=
        Vector2(velocity.x, -(velocity.y * dt - .5 * gravity * dt * dt));

    velocity.y += (acceleration + gravity) * dt;

    if ((position.y - objSize) > game.size.y) {
      removeFromParent();
      if (!divided && trash is! Rock && trash is! Coin) parent.addMistake();
    }
  }

  void touchAtPoint(Vector2 vector2) {
    if (divided) return;
    if (trash is Rock) {
      game.router.pushNamed('game-over');
      return;
    }

    final a =
        getAngleOfTouchPont(center: position, initAngle: angle, touch: vector2);

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
            position: center -
                Vector2(size.x / 2 * cos(angle), size.x / 2 * sin(angle)),
            trash: trash,
            velocity: Vector2(velocity.x - 2, velocity.y),
            divided: true,
            size: Vector2(size.x, size.y / 2),
            angle: angle,
            anchor: Anchor.topLeft),
        Throwable(dividedImage1.composeSync(),
            position: center +
                Vector2(size.x / 4 * cos(angle + 3 * pi / 2),
                    size.x / 4 * sin(angle + 3 * pi / 2)),
            size: Vector2(size.x, size.y / 2),
            angle: angle,
            anchor: Anchor.center,
            trash: trash,
            velocity: Vector2(velocity.x + 2, velocity.y),
            divided: true)
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
            position: center -
                Vector2(size.x / 4 * cos(angle), size.x / 4 * sin(angle)),
            size: Vector2(size.x / 2, size.y),
            angle: angle,
            anchor: Anchor.center,
            trash: trash,
            velocity: Vector2(velocity.x - 2, velocity.y),
            divided: true),
        Throwable(dividedImage2.composeSync(),
            position: center +
                Vector2(size.x / 2 * cos(angle + 3 * pi / 2),
                    size.x / 2 * sin(angle + 3 * pi / 2)),
            size: Vector2(size.x / 2, size.y),
            angle: angle,
            anchor: Anchor.topLeft,
            trash: trash,
            velocity: Vector2(velocity.x + 2, velocity.y),
            divided: true)
      ]);
    }

    parent.addScore(trash.point);
    removeFromParent();
  }
}
