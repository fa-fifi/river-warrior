import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:river_warrior/src/components/button.dart';
import 'package:river_warrior/src/components/countdown.dart';
import 'package:river_warrior/src/components/cross.dart';
import 'package:river_warrior/src/components/dojo.dart';
import 'package:river_warrior/src/components/scoreboard.dart';
import 'package:river_warrior/src/components/throwable.dart';
import 'package:river_warrior/src/models/item.dart';
import 'package:river_warrior/src/utils/constants.dart';

class PlayPage extends Dojo {
  late final Button pauseButton;
  late final TimerComponent timerComponent;
  late double maxVerticalVelocity;
  int mistake = 0;
  int score = 0;

  @override
  void onLoad() {
    super.onLoad();
    FlameAudio.play('countdown-start.wav', volume: game.sfxVolume);
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
            final item = items.random();
            final position =
                Vector2(Random().nextDouble() * game.size.x, game.size.y);
            add(Throwable(
              game.images.fromCache('${item.image}.png'),
              position: position,
              angle: Random().nextDouble() * 6,
              scale: item.scale,
              item: item,
              size: Vector2.all(game.size.y / 6),
              velocity: Vector2(
                  position.x < game.size.x / 2
                      ? Random().nextDouble()
                      : -Random().nextDouble(),
                  maxVerticalVelocity),
            ));
          }),
      Countdown(onCompleted: timerComponent.timer.start),
    ]);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    componentsAtPoint(event.canvasStartPosition).forEach((component) {
      if (component is Throwable && !isDisabled) {
        component.touchAtPoint(event.canvasStartPosition);
      }
    });
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    maxVerticalVelocity = sqrt(
        2 * (gravity.abs() + acceleration.abs()) * (size.y - size.y / 8 * 2));
    pauseButton.position =
        Vector2(pauseButton.size.x, size.y - pauseButton.size.y);
  }
}
