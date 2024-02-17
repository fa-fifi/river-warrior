import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:river_warrior/src/components/outlined_text.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/dojo.dart';
import '../components/throwable.dart';
import '../models/coin.dart';
import '../models/plastic.dart';
import '../models/rock.dart';
import '../models/trash.dart';

class GamePage extends Dojo with HasGameReference<RiverWarrior> {
  late final pauseButton =
      Button(id: 0, onPressed: () => game.router.pushNamed('pause'));
  late final countdownText = OutlinedText(text: 'Ready', anchor: Anchor.center);
  late final currentScoreText = OutlinedText(text: '$currentScore');
  late final highScoreText =
      OutlinedText(text: 'BEST: $highScore', scale: Vector2.all(0.5));
  late final counterText = OutlinedText(
      text: 'Mistake: $mistakeCount', position: Vector2(game.size.x - 10, 10));

  late List<double> fruitsTime;
  late double time, countDown;
  int mistakeCount = 0, currentScore = 0, highScore = 0;

  void start() {
    currentScore = 0;
    currentScoreText.text = '$currentScore';
    highScoreText.text = 'BEST: $highScore';
    mistakeCount = 0;
    counterText.text = 'Mistake: 0';
  }

  void finish() {
    game.router.pushNamed('game-over');
    if (currentScore > highScore) highScore = currentScore;
    isReleased = true;
  }

  void addScore(int point) {
    currentScore += point;
    currentScoreText.text = '$currentScore';
  }

  void addMistake() {
    mistakeCount++;
    counterText.text = 'Mistake: $mistakeCount';
    if (mistakeCount >= 3) finish();
  }

  @override
  void onMount() {
    super.onMount();

    start();

    fruitsTime = [];
    countDown = 3;
    time = 0;

    double initTime = 0;
    for (int i = 0; i < 100; i++) {
      if (i != 0) initTime = fruitsTime.last;
      final millySecondTime = Random().nextInt(100) / 100;
      final componentTime = Random().nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }

    addAll([pauseButton, countdownText]);
  }

  @override
  void onLoad() {
    super.onLoad();
    addAll([pauseButton, counterText, currentScoreText, highScoreText]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (countDown >= 0) {
      countDown -= dt;
      countdownText.text =
          switch (countDown.toInt()) { 1 => 'Set', 0 => 'Go', _ => 'Ready' };
    } else {
      countdownText.removeFromParent();

      time += dt;

      fruitsTime.where((element) => element < time).toList().forEach((element) {
        final gameSize = game.size;

        double posX = Random().nextInt(gameSize.x.toInt()).toDouble();

        Vector2 fruitPosition = Vector2(posX, gameSize.y);
        Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

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

        final shapeSize = Vector2.all(game.size.y / 5);

        add(Throwable(game.images.fromCache('${randFruit.image}.png'),
            position: fruitPosition,
            trash: randFruit,
            size: shapeSize,
            velocity: velocity));
        fruitsTime.remove(element);
      });
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

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
    countdownText.position = size / 2;
    currentScoreText.position = Vector2(pauseButton.topLeftPosition.x, 0);
    highScoreText.position =
        Vector2(pauseButton.topLeftPosition.x, currentScoreText.size.y);
  }
}
