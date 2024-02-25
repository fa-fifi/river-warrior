import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flame/palette.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/components/outlined_text.dart';

class FinishRoute extends Route {
  FinishRoute()
      : super(FinishPage.new, transparent: true, maintainState: false);

  @override
  void onPush(Route? previousRoute) => previousRoute!
    ..stopTime()
    ..addRenderEffect(PaintDecorator.grayscale(opacity: 0.5)..addBlur(3));

  @override
  void onPop(Route nextRoute) => nextRoute
    ..resumeTime()
    ..removeRenderEffect();
}

class FinishPage extends Component
    with TapCallbacks, HasGameReference<RiverWarrior> {
  late OutlinedText gameoverText;

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onLoad() {
    super.onLoad();
    FlameAudio.play('game-over.wav', volume: game.sfxVolume);
    add(gameoverText = OutlinedText(
        text: 'GAME OVER',
        textColor: BasicPalette.red.color,
        outlineColor: BasicPalette.white.color,
        anchor: Anchor.center,
        children: [
          ScaleEffect.by(
            Vector2.all(0.6),
            EffectController(
                duration: 0, reverseDuration: 0.8, alternate: true),
          ),
        ]));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    gameoverText.position = size / 2;
  }

  @override
  void onTapUp(TapUpEvent event) => game.restart();
}
