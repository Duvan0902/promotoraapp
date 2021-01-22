import 'package:flutter/material.dart';
import 'dart:math';

import 'package:MiPromotora/main.dart';

Color generateRandomColor1() {
  // Define all colors you want here
  var predefinedColors = [
    Colors.blue[900],
    MiPromotora().primaryDark,
    Colors.blue[400],
    Colors.lightBlue[400],
    Colors.cyanAccent[100],
    Colors.blue,
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
