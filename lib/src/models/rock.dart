import 'package:flutter/material.dart';

import 'throwable.dart';

class Rock extends Throwable {
  const Rock({required super.image}) : super(color: Colors.black);
}
