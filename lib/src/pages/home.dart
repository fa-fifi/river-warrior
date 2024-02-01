import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../river_warrior.dart';
import '../components/dojo.dart';
import '../components/rounded_button.dart';

class HomePage extends Dojo with HasGameReference<RiverWarrior> {
  late final title = SpriteComponent.fromImage(
      game.images.fromCache('others/title.png'),
      anchor: Anchor.topCenter);

  late final playButton = RoundedButton(
      text: 'Start',
      onPressed: () => game.router.pushNamed('game'),
      color: Colors.blue,
      borderColor: Colors.white);

  @override
  void onLoad() async {
    addAll([title, playButton]);
    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    title
      ..position = Vector2(size.x / 2, size.y / 20)
      ..size = Vector2(
          game.size.x / 3 > 475 ? 475 : game.size.x / 3,
          (game.size.x / 3) / 475 * 82 > 82
              ? 82
              : (game.size.x / 3) / 475 * 82);
    playButton.position = size / 2;
    super.onGameResize(size);
  }
}
