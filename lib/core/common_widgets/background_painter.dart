import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter{

  const BackgroundPainter({
    required this.offset
  });
  final double offset;
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..style = PaintingStyle.fill
    ..maskFilter = MaskFilter.blur(BlurStyle.inner, 8.0)
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.circleColor.withValues(alpha: 0.4),
        AppColors.circleColor01.withValues(alpha: 0.3),
      ]
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    List<double> xFractions = [0.1, 0.3, 0.5, 0.7, 0.9];
    List<double> yFractions = [0.1, 0.2, 0.3, 0.4, 0.5];

    for(int i = 0; i < xFractions.length; i++){
      canvas.drawCircle(
        Offset(
          size.width * xFractions[i],
          size.height * yFractions[i] + offset
        ),
        10 + (i * 4.0),
        paint
      );
    }

    for(int i = xFractions.length - 1; i >=0; i--){
      canvas.drawCircle(
        Offset(
          size.width * xFractions[i],
          size.height * yFractions[i] - 0.5 - offset
        ),
        10 + (i * 4.0),
        paint
      );
    }

  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}