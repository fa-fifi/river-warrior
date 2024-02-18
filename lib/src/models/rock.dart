import 'item.dart';

final class Rock extends Item {
  Rock({required super.image, required super.point}) : assert(point.isNegative);
}

final rocks = <Rock>[
  Rock(image: 'sandstone', point: -3),
  Rock(image: 'limestone', point: -6),
  Rock(image: 'coal', point: -9),
];
