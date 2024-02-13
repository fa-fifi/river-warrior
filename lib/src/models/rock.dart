import 'trash.dart';

final class Rock extends Trash {
  Rock({required super.image, required super.point}) : assert(point.isNegative);
}
