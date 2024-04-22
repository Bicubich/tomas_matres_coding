import 'package:flutter/material.dart';

class BackgroundShadingTriangle extends StatelessWidget {
  const BackgroundShadingTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TrianglePainter(),
      size: const Size(28, 28),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    double height = size.height;
    double width = size.width;

    Path path = Path()
      ..lineTo(0, height)
      ..lineTo(width, height);

    path.quadraticBezierTo(-2, height + 2, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
