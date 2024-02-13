import 'trash.dart';

final class Coin extends Trash {
  Coin({required super.image, required super.point})
      : assert(!point.isNegative);
}
