import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flame/rendering.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/components/button.dart';
import 'package:river_warrior/src/components/outlined_text.dart';

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
  late final OutlinedText pauseText;
  late final Button retryButton;
  late final Button exitButton;
  late final Button continueButton;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    addAll([
      pauseText =
          OutlinedText(text: 'PAUSED', anchor: Anchor.center, children: [
        ScaleEffect.to(Vector2.all(1.1),
            EffectController(duration: 0.3, alternate: true, infinite: true)),
      ]),
      retryButton = Button(
          id: 5,
          onPressed: () => game.router
            ..popUntilNamed('start')
            ..pushNamed('play')),
      exitButton = Button(id: 3, onPressed: game.restart),
      continueButton = Button(id: 6, onPressed: game.router.pop)
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    pauseText.position = Vector2(size.x / 2, size.y / 2 - retryButton.size.y);
    retryButton.position = Vector2(size.x / 2, size.y / 2 + retryButton.size.y);
    exitButton.position =
        Vector2(size.x / 2 - retryButton.size.x * 2, retryButton.position.y);
    continueButton.position =
        Vector2(size.x / 2 + retryButton.size.x * 2, retryButton.position.y);
  }
}
