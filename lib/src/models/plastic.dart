import 'item.dart';

final class Plastic extends Item {
  const Plastic({required super.image}) : super(point: 1);
}

const plastics = <Plastic>[
  Plastic(image: 'container'),
  Plastic(image: 'cup'),
  Plastic(image: 'drink'),
  Plastic(image: 'fork'),
  Plastic(image: 'plastic'),
  Plastic(image: 'rings'),
  Plastic(image: 'spoon'),
  Plastic(image: 'straw'),
];
