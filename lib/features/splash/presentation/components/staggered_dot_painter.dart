import 'dart:math';
import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class StaggeredDotPainter extends CustomPainter{
  final List<Animation<double>> animations;
  StaggeredDotPainter({required this.animations});


  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primaryBrandColor.withValues(alpha: 0.4),
        AppColors.primaryBrandColor.withValues(alpha: 0.3),
      ]
    )
    .createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const dotCount = 3.0;
    const dotRadius = 6.0;
    const double dotSpacing = 8.0; // The gap BETWEEN the dots

    // Calculate the total width of the 3 dots
    double totalWidth = (dotCount * (dotRadius * 2)) + ((dotCount - 1) * dotSpacing);

    // Find the starting x position to center the whole dots
    double startX = (size.width - totalWidth) / 2 + dotRadius;
    double yCenter = size.height / 2;

    for(int i = 0; i < 3; i++){
      
      double bounce = sin(animations[i].value * pi);
      double yOffset = bounce * 15; // 15 max height jump of the dot

      // Calculate each dot X based on the startX
      double xPos = startX + (i * (dotRadius * 2 + dotSpacing));

      canvas.drawCircle(
        Offset(xPos, yCenter - yOffset), 
        dotRadius,
        paint
      ); 
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}