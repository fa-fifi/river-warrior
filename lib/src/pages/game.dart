import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/dojo.dart';
import '../components/throwable.dart';
import '../models/coin.dart';
import '../models/plastic.dart';
import '../models/rock.dart';
import '../models/trash.dart';

class GamePage extends Dojo with HasGameReference<RiverWarrior> {
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
    for (int i = 0; i < 100; i++) {
      if (i != 0) initTime = fruitsTime.last;
      final millySecondTime = Random().nextInt(100) / 100;
      final componentTime = Random().nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }

    addAll([
      Button(
          id: 4,
          position: Vector2.all(30),
          onPressed: () {
            removeAll(children);
            game.router.pop();
          }),
      Button(
          id: 0,
          position: Vector2(85, 30),
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

  void gameOver() {
    game.router.pushNamed('game-over');
  }

  void addScore(int point) {
    score = score + point;
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
