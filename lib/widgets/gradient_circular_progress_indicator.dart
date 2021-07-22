import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double stokeWidth;
  final double radius;
  final bool strokeCapRound;
  final double? value;
  final Color? backgroundColor;
  final double? totalAngle;
  final List<Color>? colors;
  final List<double>? stops;

  GradientCircularProgressIndicator(
      {this.stokeWidth = 2.0,
      required this.radius,
      this.strokeCapRound = false,
      this.value,
      this.backgroundColor,
      this.totalAngle,
      required this.colors,
      this.stops});

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound) {
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    var painter = _GradientCircularProgressPainter(
      stokeWidth: stokeWidth,
      strokeCapRound: strokeCapRound,
      backgroundColor: backgroundColor ?? Color(0xFFEEEEEE),
      value: value,
      total: totalAngle ?? pi * 2,
      radius: radius,
      colors: _colors,
    );

    return Transform.rotate(
      angle: -pi / 2 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: painter,
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double stokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;

  _GradientCircularProgressPainter(
      {this.stokeWidth: 10.0,
      this.strokeCapRound: false,
      this.value,
      this.backgroundColor: const Color(0xFFEEEEEE),
      required this.colors,
      this.total: pi * 2,
      this.radius,
      this.stops});

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius!);
    }
    double _offset = stokeWidth / 2.0;
    double _value = value ?? .0;
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(stokeWidth / (size.width - stokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = stokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              colors: colors, startAngle: 0.0, endAngle: _value, stops: stops)
          .createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
