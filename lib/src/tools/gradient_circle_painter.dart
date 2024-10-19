import 'dart:math';

import 'package:flutter/material.dart';

class GradientCirclePainter extends CustomPainter {
  final Gradient? gradientColors;
  final double withBorder;

  GradientCirclePainter({
    this.gradientColors,
    required this.withBorder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const startAngle = -pi / 2;
    const sweepAngle = 2 * pi;

    final List<Color> colors =
        gradientColors?.colors ?? [Colors.blue, Colors.green];

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: colors,
    );

    final rect = Rect.fromCircle(center: center, radius: size.width / 2);

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = withBorder;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
