import 'dart:math';

import 'package:flutter/material.dart';

class GradientRandomTools {
  static const List<List<Color>> _predefinedGradients = [
    // Deep Blues
    [Color(0xFF1A237E), Color(0xFF0D47A1)],
    [Color(0xFF0D47A1), Color(0xFF1976D2)],
    [Color(0xFF1976D2), Color(0xFF42A5F5)],

    // Rich Purples
    [Color(0xFF4A148C), Color(0xFF311B92)],
    [Color(0xFF311B92), Color(0xFF6A1B9A)],
    [Color(0xFF6A1B9A), Color(0xFFAB47BC)],

    // Vibrant Reds
    [Color(0xFFB71C1C), Color(0xFFC62828)],
    [Color(0xFFC62828), Color(0xFFD32F2F)],
    [Color(0xFFD32F2F), Color(0xFFEF5350)],

    // Forest Greens
    [Color(0xFF1B5E20), Color(0xFF2E7D32)],
    [Color(0xFF2E7D32), Color(0xFF43A047)],
    [Color(0xFF43A047), Color(0xFF66BB6A)],

    // Warm Oranges
    [Color(0xFFE65100), Color(0xFFEF6C00)],
    [Color(0xFFEF6C00), Color(0xFFF57C00)],
    [Color(0xFFF57C00), Color(0xFFFFA726)],

    // Purple to Pink
    [Color(0xFF4A148C), Color(0xFFAD1457)],
    [Color(0xFFAD1457), Color(0xFFD81B60)],
    [Color(0xFFD81B60), Color(0xFFEC407A)],

    // Deep Teals
    [Color(0xFF004D40), Color(0xFF00695C)],
    [Color(0xFF00695C), Color(0xFF00796B)],
    [Color(0xFF00796B), Color(0xFF26A69A)],

    // Ocean Blues
    [Color(0xFF1A237E), Color(0xFF006064)],
    [Color(0xFF006064), Color(0xFF00838F)],
    [Color(0xFF00838F), Color(0xFF26C6DA)],

    // Rich Browns
    [Color(0xFF3E2723), Color(0xFF4E342E)],
    [Color(0xFF4E342E), Color(0xFF5D4037)],
    [Color(0xFF5D4037), Color(0xFF795548)],

    // Blue Greys
    [Color(0xFF263238), Color(0xFF37474F)],
    [Color(0xFF37474F), Color(0xFF546E7A)],
    [Color(0xFF546E7A), Color(0xFF78909C)],

    // Sunburst Yellows
    [Color(0xFFF57F17), Color(0xFFFFA000)],
    [Color(0xFFFFA000), Color(0xFFFFCA28)],
    [Color(0xFFFFCA28), Color(0xFFFFEE58)],

    // Rose Pinks
    [Color(0xFF880E4F), Color(0xFFC2185B)],
    [Color(0xFFC2185B), Color(0xFFE91E63)],
    [Color(0xFFE91E63), Color(0xFFF06292)],

    // Additional Dynamic Combinations
    [Color.fromARGB(255, 63, 81, 181), Color.fromARGB(255, 33, 150, 243)],
    [Color.fromARGB(255, 76, 175, 80), Color.fromARGB(255, 139, 195, 74)],
    [Color.fromARGB(255, 244, 67, 54), Color.fromARGB(255, 255, 82, 82)],
    [Color.fromARGB(255, 33, 150, 243), Color.fromARGB(255, 3, 169, 244)],
    [Color.fromARGB(255, 156, 39, 176), Color.fromARGB(255, 225, 190, 231)],
  ];

  static final List<Color> _baseColors = [
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.red,
  ];

  static final List<List<Color>> _materialGradients = [
    for (var primary in Colors.primaries)
      [
        primary.shade900,
        primary.shade700,
        primary.shade500,
      ]
  ];

  static List<Color> _mixColors(Color color1, Color color2, {int steps = 3}) {
    List<Color> colors = [];
    for (int i = 0; i < steps; i++) {
      double factor = i / (steps - 1);
      colors.add(Color.lerp(color1, color2, factor)!);
    }
    return colors;
  }

  static LinearGradient getGradient(
    String name, {
    bool material = false,
    bool dynamicMix = false,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    final random = Random(name.hashCode.abs());

    List<Color> colors;
    List<double> stops;

    if (dynamicMix) {
      // Generate dynamic color mix
      final color1 = _baseColors[random.nextInt(_baseColors.length)];
      final color2 = _baseColors[random.nextInt(_baseColors.length)];
      colors = _mixColors(color1, color2);
      stops = [0.0, 0.5, 1.0];
    } else if (material) {
      // Use material design gradients
      colors = _materialGradients[random.nextInt(_materialGradients.length)];
      stops = [0.0, 0.5, 1.0];
    } else {
      // Use predefined gradients
      colors =
          _predefinedGradients[random.nextInt(_predefinedGradients.length)];
      stops = List.generate(
        colors.length,
        (index) => index / (colors.length - 1),
      );
    }

    return LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
    );
  }

  static LinearGradient customGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    if (stops != null && colors.length != stops.length) {
      throw ArgumentError('Colors and stops must have equal length');
    }

    return LinearGradient(
      colors: colors,
      stops: stops ??
          List.generate(
            colors.length,
            (index) => index / (colors.length - 1),
          ),
      begin: begin,
      end: end,
    );
  }

  // Helper method for creating complementary color gradients
  static LinearGradient complementaryGradient(Color baseColor) {
    final HSLColor hslColor = HSLColor.fromColor(baseColor);
    final HSLColor complementary = hslColor.withHue((hslColor.hue + 180) % 360);

    return LinearGradient(
      colors: [baseColor, complementary.toColor()],
      stops: const [0.0, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
