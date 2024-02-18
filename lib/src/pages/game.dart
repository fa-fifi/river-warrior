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
import '../models/item.dart';
import '../utils/constants.dart';

class GamePage extends Dojo with HasGameReference<RiverWarrior> {
  late final Button pauseButton;
  late final TimerComponent timerComponent;
  late double maxVerticalVelocity;
  int mistake = 0, score = 0;

  void finish() {
    game.router.pushNamed('game-over');
    isReleased = true;
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
      timerComponent = TimerComponent(
          period: 1,
          repeat: true,
          autoStart: false,
          removeOnFinish: true,
          onTick: () {
            final randomItem = items.random();
            add(Throwable(game.images.fromCache('${randomItem.image}.png'),
                position:
                    Vector2(Random().nextDouble() * game.size.x, game.size.y),
                trash: randomItem,
                size: Vector2.all(game.size.y / 5),
                velocity: Vector2(0, maxVerticalVelocity)));
          }),
      Countdown(onCompleted: timerComponent.timer.start),
    ]);
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
    maxVerticalVelocity =
        sqrt(2 * (gravity.abs() + acceleration.abs()) * (size.y - objSize * 2));
    pauseButton.position =
        Vector2(pauseButton.size.x, size.y - pauseButton.size.y);
  }
}
