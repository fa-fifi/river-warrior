import 'coin.dart';
import 'plastic.dart';
import 'rock.dart';

abstract class Item {
  final String image;
  final int point;

  const Item({required this.image, required this.point});
}

final items = <Item>[...plastics, ...coins, ...rocks];
