import 'item.dart';

final class Rock extends Item {
  const Rock(super.image, {super.scaleFactor}) : super(point: -10);
}

const rocks = <Rock>[
  Rock('sandstone'),
  Rock('limestone'),
  Rock('coal'),
];
