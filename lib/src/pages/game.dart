import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/countdown.dart';
import '../components/cross.dart';
import '../components/dojo.dart';
import '../components/scoreboard.dart';
import '../components/throwable.dart';
import '../models/coin.dart';
import '../models/plastic.dart';
import '../models/rock.dart';
import '../models/trash.dart';

class GamePage extends Dojo with HasGameReference<RiverWarrior> {
  late final Button pauseButton;
  late double time;
  late int mistake, score;

  void finish() {
    game.router.pushNamed('game-over');
    isReleased = true;
  }

  @override
  void onMount() {
    super.onMount();
    time = 0;
    score = 0;
    mistake = 0;
    add(Countdown());
  }

  @override
  void onLoad() {
    super.onLoad();
    addAll([
      Scoreboard(),
      ...List<Cross>.generate(game.maxMistake,
          (n) => Cross(count: n, scale: Vector2.all(1 + n / 8))),
      pauseButton =
          Button(id: 0, onPressed: () => game.router.pushNamed('pause')),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    if (children.whereType<Countdown>().isNotEmpty) return;
    if ((time + dt).toInt() > time.toInt()) {
      final List<Trash> fruits = [
        const Plastic(image: 'fork'),
        const Plastic(image: 'spoon'),
        const Plastic(image: 'cup'),
        const Plastic(image: 'straw'),
        const Plastic(image: 'drink'),
        const Plastic(image: 'container'),
        const Plastic(image: 'rings'),
        const Plastic(image: 'plastic'),
        Rock(image: 'sandstone', point: -3),
        Rock(image: 'limestone', point: -6),
        Rock(image: 'coal', point: -9),
        Coin(image: 'copper', point: 3),
        Coin(image: 'silver', point: 6),
        Coin(image: 'gold', point: 9),
      ];

      final randFruit = fruits.random();

      add(Throwable(game.images.fromCache('${randFruit.image}.png'),
          position: Vector2(
              Random().nextInt(game.size.x.toInt()).toDouble(), game.size.y),
          trash: randFruit,
          size: Vector2.all(game.size.y / 5),
          velocity: Vector2(0, game.maxVerticalVelocity)));
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    componentsAtPoint(event.canvasStartPosition).forEach((component) {
      if (component is Throwable) {
        component.touchAtPoint(event.canvasStartPosition);
      }
    });
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    pauseButton.position =
        Vector2(pauseButton.size.x, size.y - pauseButton.size.y);
  }
}
