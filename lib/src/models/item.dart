import 'package:flame/game.dart';

import 'coin.dart';
import 'plastic.dart';
import 'rock.dart';

abstract class Item {
  final String image;
  final int point;
  final double scaleFactor;

  const Item(this.image, {required this.point, this.scaleFactor = 1});

  Vector2 get scale => Vector2.all(scaleFactor);
}

final items = <Item>[...plastics, ...coins, ...rocks];
