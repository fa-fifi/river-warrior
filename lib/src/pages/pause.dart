import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flame/rendering.dart';

import '../../river_warrior.dart';
import '../components/button.dart';
import '../components/outlined_text.dart';

class PauseRoute extends Route {
  PauseRoute() : super(PausePage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) => previousRoute!
    ..stopTime()
    ..addRenderEffect(PaintDecorator.grayscale(opacity: 0.5)..addBlur(3));

  @override
  void onPop(Route nextRoute) => nextRoute
    ..resumeTime()
    ..removeRenderEffect();
}

class PausePage extends Component with HasGameReference<RiverWarrior> {
  late final text =
      OutlinedText(text: 'PAUSED', anchor: Anchor.center, children: [
    ScaleEffect.to(Vector2.all(1.1),
        EffectController(duration: 0.3, alternate: true, infinite: true)),
  ]);
  late final exitButton =
      Button(id: 3, onPressed: () => game.router.popUntilNamed('start'));
  late final retryButton = Button(
      id: 5,
      onPressed: () => game.router
        ..popUntilNamed('start')
        ..pushNamed('play'));
  late final continueButton = Button(id: 6, onPressed: game.router.pop);

  @override
  Future<void> onLoad() async {
    addAll([text, exitButton, retryButton, continueButton]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    text.position = Vector2(size.x / 2, size.y / 2 - retryButton.size.y);
    retryButton.position = Vector2(size.x / 2, size.y / 2 + retryButton.size.y);
    exitButton.position =
        Vector2(size.x / 2 - retryButton.size.x * 2, retryButton.position.y);
    continueButton.position =
        Vector2(size.x / 2 + retryButton.size.x * 2, retryButton.position.y);
  }
}
