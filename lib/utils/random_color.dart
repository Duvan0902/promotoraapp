import 'package:flutter/material.dart';
import 'dart:math';

Color generateRandomColor() {
  // Define all colors you want here
  var predefinedColors = [
    Colors.lightBlue[400],
    Colors.lightBlue[500],
    Colors.lightBlue[600],
    Colors.lightBlue[700],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.cyan[400],
    Colors.cyan[500],
    Colors.cyan[600],
    Colors.cyan[700],
  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
