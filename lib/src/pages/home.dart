import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/dojo.dart';

class HomePage extends Dojo with HasGameReference<RiverWarrior> {
  late final title = SpriteComponent.fromImage(
      game.images.fromCache('title.png'),
      anchor: Anchor.topCenter,
      priority: 1);
  late final playButton = SpriteComponent.fromImage(
      game.images.fromCache('drink.png'),
      anchor: Anchor.center,
      children: [
        RotateEffect.to(-0.1,
            EffectController(duration: 0.5, infinite: true, alternate: true))
      ]);
  late final gearButton = Button(id: 8);
  late final starButton = Button(id: 1);
  late final helpButton = Button(id: 7);
  late final infoButton = Button(id: 2);
  bool readyToPlay = false;

  @override
  void onMount() async {
    super.onMount();
    addAll([title, playButton, gearButton, starButton, helpButton, infoButton]);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (componentsAtPoint(event.canvasStartPosition).contains(playButton)) {
      isReleased = true;
      game.router.pushNamed('game');
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    title
      ..position = Vector2(size.x / 2, game.size.y / 30)
      ..size = Vector2(size.y / 7 * 5, size.y / 7);
    playButton
      ..position = size / 2
      ..size = Vector2(size.y * 0.45, size.y * 0.45);
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
