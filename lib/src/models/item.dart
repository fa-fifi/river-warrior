import 'package:flame/game.dart';
import 'package:river_warrior/src/models/coin.dart';
import 'package:river_warrior/src/models/plastic.dart';
import 'package:river_warrior/src/models/rock.dart';

abstract class Item {
  final String image;
  final int point;
  final double scaleFactor;

  const Item(this.image, {required this.point, this.scaleFactor = 1});

  Vector2 get scale => Vector2.all(scaleFactor);
}

final items = <Item>[...plastics, ...coins, ...rocks];
