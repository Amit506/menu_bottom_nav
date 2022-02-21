
import 'package:flutter/material.dart';
import 'dart:math' as math;
class ArcPainter extends CustomPainter {
  final double progress;
  final double strokewidth;
  final Color color;
  ArcPainter(
      {required this.progress, required this.strokewidth, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = math.min(centerY, centerX);

    var centerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth
      ..color = color;
    canvas.drawArc(
        Rect.fromCenter(
          center: center,
          height: size.height,
          width: size.width,
        ),
        (math.pi - 0.4) * progress,
        (math.pi + 0.8) * progress,
        false,
        centerPaint);

    var path = Path();
    var painter = Paint()..color = Colors.black;

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class CustomClip extends CustomClipper<Path> {
  final double radius;

  CustomClip(this.radius);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}