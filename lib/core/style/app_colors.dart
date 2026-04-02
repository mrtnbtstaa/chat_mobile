import 'package:flutter/material.dart';

class AppColors {

  static const Color white100 = Color(0xffFFFFFF);

  // Buttons primary
  static const Color primaryBrandColor = Color(0xff3D5AFE);

  // Light mode palette
  static const Color lBaseBackground = Color(0xffF9F9FF);
  static const Color lSurfaceLow = Color(0xffF3F3F9); // Inputs, Secondary Container
  static const Color lSurfaceMedium = Color(0xffEBEBF5); // Hover states and subtle elevations
  static const Color ltextPrimary = Color(0xff191C20);
  static Color ltextSecondary = ltextPrimary.withValues(alpha: 0.6);
  static const Color lBorderDivider = Color(0xffF3F3F9);


  // Dark mode palette
  static const Color dBaseBackground = Color(0xff0C0E12);
  static const Color dSurfaceLow = Color(0xff171A1F);
  static const Color dSurfaceMedium = Color(0xff1D2025);
  static const Color dTextPrimary = Color(0xffF6F6FC);
  static const Color dTextSecondary = Color(0xffAAABB0);
  static const Color dBorderDivider = Color.fromARGB(255, 33, 37, 44);
  static const Color incomingMessageBubble = Color(0xff171A1F);
  static const Color outgoingMessageBubble = Color(0xff3D5AFE);


  // State Colors
  static const Color success = Color(0xff00C853);
  static const Color error = Color(0xffFF3D00);
  static const Color warning = Color(0xffFFD600);
  static const Color info = Color(0xff2979FF);

}