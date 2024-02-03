import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/dojo.dart';
import '../components/fruit_component.dart';
import '../models/plastic.dart';
import '../models/rock.dart';
import '../models/throwable.dart';
import '../utils/constants.dart';

class GamePage extends Dojo with HasGameReference<RiverWarrior> {
  final Random random = Random();
  late List<double> fruitsTime;
  late double time, countDown;
  TextComponent? _countdownTextComponent,
      _mistakeTextComponent,
      _scoreTextComponent;
  bool _countdownFinished = false;
  late int mistakeCount, score;

  @override
  void onMount() {
    super.onMount();

    fruitsTime = [];
    countDown = 3;
    mistakeCount = 0;
    score = 0;
    time = 0;
    _countdownFinished = false;

    double initTime = 0;
    for (int i = 0; i < 40; i++) {
      if (i != 0) {
        initTime = fruitsTime.last;
      }
      final millySecondTime = random.nextInt(100) / 100;
      final componentTime = random.nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }

    addAll([
      Button(
          id: 4,
          position: Vector2.all(30),
          size: Vector2.all(50),
          onPressed: () {
            removeAll(children);
            game.router.pop();
          }),
      Button(
          id: 0,
          position: Vector2(85, 30),
          size: Vector2.all(50),
          onPressed: () => game.router.pushNamed('pause')),
      _countdownTextComponent = TextComponent(
        text: '${countDown.toInt() + 1}',
        size: Vector2.all(50),
        position: game.size / 2,
        anchor: Anchor.center,
      ),
      _mistakeTextComponent = TextComponent(
        text: 'Mistake: $mistakeCount',
        // 10 is padding
        position: Vector2(game.size.x - 10, 10),
        anchor: Anchor.topRight,
      ),
      _scoreTextComponent = TextComponent(
        text: 'Score: $score',
        position:
            Vector2(game.size.x - 10, _mistakeTextComponent!.position.y + 40),
        anchor: Anchor.topRight,
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_countdownFinished) {
      countDown -= dt;

      _countdownTextComponent?.text = (countDown.toInt() + 1).toString();
      if (countDown < 0) {
        _countdownFinished = true;
      }
    } else {
      _countdownTextComponent?.removeFromParent();

      time += dt;

      fruitsTime.where((element) => element < time).toList().forEach((element) {
        final gameSize = game.size;

        double posX = random.nextInt(gameSize.x.toInt()).toDouble();

        Vector2 fruitPosition = Vector2(posX, gameSize.y);
        Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

        final List<Throwable> fruits = [
          const Plastic(image: 'throwables/apple.png'),
          const Plastic(image: 'throwables/banana.png'),
          const Plastic(image: 'throwables/kiwi.png'),
          const Plastic(image: 'throwables/orange.png'),
          const Plastic(image: 'throwables/peach.png'),
          const Plastic(image: 'throwables/pineapple.png'),
          const Rock(image: 'throwables/bomb.png'),
        ];

        final randFruit = fruits.random();

        add(FruitComponent(
          this,
          fruitPosition,
          acceleration: acceleration,
          fruit: randFruit,
          size: shapeSize,
          image: game.images.fromCache(randFruit.image),
          pageSize: gameSize,
          velocity: velocity,
        ));
        fruitsTime.remove(element);
      });
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    componentsAtPoint(event.canvasStartPosition).forEach((element) {
      if (element is FruitComponent) {
        if (element.canDragOnShape) {
          element.touchAtPoint(event.canvasStartPosition);
        }
      }
    });
  }

  void gameOver() {
    game.router.pushNamed('game-over');
  }

  void addScore() {
    score++;
    _scoreTextComponent?.text = 'Score: $score';
  }

  void addMistake() {
    mistakeCount++;
    _mistakeTextComponent?.text = 'Mistake: $mistakeCount';
    if (mistakeCount >= 3) {
      gameOver();
    }
  }
}
