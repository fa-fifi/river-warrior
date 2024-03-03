import 'package:flame/game.dart';
import 'package:river_warrior/src/models/coin.dart';
import 'package:river_warrior/src/models/plastic.dart';
import 'package:river_warrior/src/models/rock.dart';

abstract class Item {
  final String name;
  final int point;
  final double scaleFactor;

  const Item(this.name, {required this.point, this.scaleFactor = 1});

  String get image => 'items/$name.png';

  Vector2 get scale => Vector2.all(scaleFactor);
}

final items = <Item>[...plastics, ...coins, ...rocks];
