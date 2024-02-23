import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart' as composition;
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/models/item.dart';
import 'package:river_warrior/src/models/plastic.dart';
import 'package:river_warrior/src/models/rock.dart';
import 'package:river_warrior/src/pages/play.dart';
import 'package:river_warrior/src/utils/constants.dart';
import 'package:river_warrior/src/utils/helpers.dart';

class Throwable extends SpriteComponent
    with ParentIsA<PlayPage>, HasGameReference<RiverWarrior> {
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
      : super.fromImage() {
    if (item is Rock) scale = Vector2.all(1 - Random().nextDouble() * 0.4);
  }

  void finish() {
    game.router.pushNamed('finish');
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

    if (parent.score >= threshold &&
        parent.score % threshold < 10 &&
        parent.mistake > 0 &&
        item is! Rock) {
      parent.mistake--;
    }

    final a = getSliceAngle(center: center, initAngle: angle, touch: vector2);

    if (a < 45 || (a > 135 && a < 225) || a > 315) {
      final dividedImage1 = composition.ImageComposition()
        ..add(sprite!.image, Vector2(0, 0),
            source: Rect.fromLTWH(0, 0, sprite!.image.width.toDouble(),
                sprite!.image.height / 2));
      final dividedImage2 = composition.ImageComposition()
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
                sprite!.image.height.toDouble()));
      final dividedImage2 = composition.ImageComposition()
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
