import 'package:river_warrior/src/models/item.dart';

final class Coin extends Item {
  Coin(super.image, {required super.point})
      : assert(!point.isNegative),
        super(scaleFactor: 0.6);
}

final coins = <Coin>[
  Coin('copper', point: 3),
  Coin('silver', point: 6),
  Coin('gold', point: 9),
];
