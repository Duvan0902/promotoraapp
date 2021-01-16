import 'package:flutter/material.dart';
import 'dart:math';

import 'package:promotoraapp/main.dart';

class UniqueColorGenerator {
  static List colorOptions = [
    PromotoraApp().primaryDark,
    Colors.blue[900],
    Colors.blue[400],
    Colors.cyanAccent[100],
  ];
  static Random random = new Random();
  static Color getColor() {
    if (colorOptions.length > 0) {
      return colorOptions.removeAt(random.nextInt(colorOptions.length));
    } else {
      return Color.fromARGB(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
      );
    }
  }
}
