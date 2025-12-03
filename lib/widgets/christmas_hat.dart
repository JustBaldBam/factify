import 'package:flutter/material.dart';

// 1. Christmas Hat Painter
class ChristmasHatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final redPaint = Paint()..color = const Color(0xFFDC2626); 
    final whitePaint = Paint()..color = Colors.white;

    final conePath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.95)
      ..lineTo(size.width * 0.9, size.height * 0.95)
      ..lineTo(size.width * 0.75, size.height * 0.40)
      ..lineTo(size.width * 0.40, size.height * 0.05)
      ..close();
    canvas.drawPath(conePath, redPaint);

    final rimPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.95)
      ..cubicTo(
        size.width * 0.2, size.height * 0.85,
        size.width * 0.8, size.height * 0.85,
        size.width * 0.9, size.height * 0.95,
      )
      ..lineTo(size.width * 0.9, size.height * 0.85)
      ..cubicTo(
        size.width * 0.8, size.height * 0.75,
        size.width * 0.2, size.height * 0.75,
        size.width * 0.1, size.height * 0.85,
      )
      ..close();
    canvas.drawPath(rimPath, whitePaint);

    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.10), size.width * 0.1, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 2. Christmas Hat Widget
class ChristmasHat extends StatelessWidget {
  final double size;
  const ChristmasHat({super.key, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 6 * (3.1415926535 / 180), // 6 degrees rotation
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: ChristmasHatPainter(),
        ),
      ),
    );
  }
}