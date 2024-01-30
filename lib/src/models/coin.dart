import 'package:flutter/material.dart';

import 'throwable.dart';

class Coin extends Throwable {
  const Coin({required super.image}) : super(color: Colors.amber);
}
