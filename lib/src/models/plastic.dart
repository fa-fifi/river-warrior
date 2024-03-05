import 'package:river_warrior/src/models/item.dart';

final class Plastic extends Item {
  const Plastic(super.image, {super.scaleFactor}) : super(point: 1);
}

const plastics = <Plastic>[
  Plastic('bag', scaleFactor: 1.5),
  Plastic('container', scaleFactor: 1.2),
  Plastic('cup', scaleFactor: 0.8),
  Plastic('drink', scaleFactor: 1.6),
  Plastic('fork', scaleFactor: 0.9),
  Plastic('rings', scaleFactor: 1.2),
  Plastic('spoon', scaleFactor: 0.9),
  Plastic('straw'),
];
