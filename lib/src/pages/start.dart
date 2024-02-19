import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import '../components/button.dart';
import '../components/dojo.dart';

class StartPage extends Dojo {
  late final title = SpriteComponent.fromImage(
      game.images.fromCache('title.png'),
      anchor: Anchor.topCenter,
      priority: 1);
  late final hitbox =
      RectangleHitbox(anchor: Anchor.center, size: Vector2.all(10));
  late final playButton = SpriteComponent.fromImage(
      game.images.fromCache('drink.png'),
      anchor: Anchor.center,
      children: [
        RotateEffect.to(-0.1,
            EffectController(duration: 0.5, infinite: true, alternate: true)),
        hitbox
      ]);
  late final gearButton = Button(id: 8);
  late final starButton = Button(id: 1);
  late final helpButton = Button(id: 7);
  late final infoButton = Button(id: 2);

  @override
  void onMount() async {
    super.onMount();
    addAll([title, playButton, gearButton, starButton, helpButton, infoButton]);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (componentsAtPoint(event.canvasStartPosition).contains(hitbox)) {
      isReleased = true;
      game.router.pushNamed('play');
    }
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
