import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:river_warrior/river_warrior.dart';

class Background extends SpriteComponent with HasGameRef<RiverWarrior> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load('bg.png');
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
