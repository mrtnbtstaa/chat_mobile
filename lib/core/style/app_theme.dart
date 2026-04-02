import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "Inter",
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBrandColor,
    textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.ltextPrimary,
    selectionColor: AppColors.ltextPrimary,
    selectionHandleColor: AppColors.ltextPrimary,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateColor.resolveWith((_) => AppColors.dSurfaceLow)
    )
  ),
  iconTheme: IconThemeData(
    color: AppColors.dSurfaceLow
  ),
  cardColor: AppColors.lSurfaceLow,
  cardTheme: CardThemeData(color: AppColors.lSurfaceLow),
  dividerTheme: DividerThemeData(color: AppColors.lBorderDivider),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.primaryBrandColor),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: AppColors.ltextPrimary,
          fontSize: AppSizes.font14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: AppColors.ltextSecondary,
      fontSize: 18,
      )
    ),
    textTheme: TextTheme().copyWith(
      bodyMedium: TextStyle(color: AppColors.ltextPrimary),
      bodyLarge: TextStyle(color: AppColors.ltextPrimary),
      bodySmall: TextStyle(color: AppColors.ltextSecondary),
    ),
);

ThemeData darkTheme = ThemeData(
    fontFamily: "Inter",
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBrandColor,
    textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.dTextPrimary,
    selectionColor: AppColors.dTextPrimary,
    selectionHandleColor: AppColors.dTextPrimary,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateColor.resolveWith((_) => AppColors.lSurfaceLow)
    )
  ),
  iconTheme: IconThemeData(
    color: AppColors.lSurfaceLow
  ),
  cardColor: AppColors.dSurfaceLow,
  cardTheme: CardThemeData(color: AppColors.dSurfaceLow),
  dividerTheme: DividerThemeData(color: AppColors.dBorderDivider),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.primaryBrandColor),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: AppColors.dTextPrimary,
          fontSize: AppSizes.font14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
    scaffoldBackgroundColor: AppColors.dBaseBackground,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
    color: AppColors.dTextSecondary,
    fontSize: 18,
    ),
    ),
    textTheme: TextTheme().copyWith(
      bodyMedium: TextStyle(color: AppColors.dTextPrimary),
      bodyLarge: TextStyle(color: AppColors.dTextPrimary),
      bodySmall: TextStyle(color: AppColors.dTextSecondary),
    ),
);