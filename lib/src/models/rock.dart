import 'item.dart';

final class Rock extends Item {
  Rock(super.image, {required super.point}) : assert(point.isNegative);
}

final rocks = <Rock>[
  Rock('sandstone', point: -3),
  Rock('limestone', point: -6),
  Rock('coal', point: -9),
];
