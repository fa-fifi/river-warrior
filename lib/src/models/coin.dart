import 'item.dart';

final class Coin extends Item {
  Coin({required super.image, required super.point})
      : assert(!point.isNegative);
}

final coins = <Coin>[
  Coin(image: 'copper', point: 3),
  Coin(image: 'silver', point: 6),
  Coin(image: 'gold', point: 9),
];
