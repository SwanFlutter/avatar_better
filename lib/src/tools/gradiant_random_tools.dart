import 'dart:math';

import 'package:flutter/material.dart';

class GradientRandomTools {
  static LinearGradient getGradient(String name) {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.yellow,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
      Colors.cyan,
      Colors.lime,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.amber,
      Colors.blueGrey,
      Colors.brown,
      Colors.cyan,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.green,
      Colors.indigo,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.lime,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.yellow,
    ];
    final int hash = name.hashCode.abs();
    final Random random = Random(hash);
    final int index1 = random.nextInt(colors.length);

    int index2 = random.nextInt(colors.length);

    return LinearGradient(
      colors: [colors[index1], colors[index2]],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    );
  }
}
