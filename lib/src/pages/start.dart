import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';

import '../components/button.dart';
import '../components/dojo.dart';

class StartPage extends Dojo {
  late final PositionComponent title, playButton, hitbox;
  late final Button gearButton, starButton, helpButton, infoButton;

  @override
  void onLoad() async {
    super.onLoad();
    addAll([
      title = SpriteComponent.fromImage(game.images.fromCache('title.png'),
          anchor: Anchor.topCenter, priority: 1),
      playButton = SpriteComponent.fromImage(game.images.fromCache('drink.png'),
          anchor: Anchor.center,
          children: [
            RotateEffect.to(
              .1,
              EffectController(duration: 0.5, infinite: true, alternate: true),
            ),
            hitbox =
                RectangleHitbox(anchor: Anchor.center, size: Vector2.all(10))
          ]),
      gearButton = Button(id: 8),
      starButton = Button(id: 1),
      helpButton = Button(id: 7),
      infoButton = Button(id: 2),
    ]);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!componentsAtPoint(event.canvasStartPosition).contains(hitbox)) return;
    isReleased = true;
    game.router.pushNamed('play');
    FlameAudio.bgm.stop();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    title
      ..position = Vector2(size.x / 2, 10)
      ..size = Vector2(size.y / 7 * 5, size.y / 7);
    playButton
      ..position = size / 2
      ..size = Vector2(size.y * 0.45, size.y * 0.45);
    hitbox
      ..position = playButton.size / 2
      ..size = Vector2(playButton.size.x * 0.1, size.y * 0.4);
    starButton.position =
        Vector2(size.x / 2 - starButton.size.x, size.y - starButton.size.y);
    helpButton.position =
        Vector2(size.x / 2 + starButton.size.x, starButton.position.y);
    gearButton.position =
        Vector2(size.x / 2 - starButton.size.x * 3, starButton.position.y);
    infoButton.position =
        Vector2(size.x / 2 + starButton.size.x * 3, starButton.position.y);
  }
}
