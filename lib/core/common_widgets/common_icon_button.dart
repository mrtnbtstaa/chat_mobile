import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../extensions/context_extension.dart';

class CommonIconButton extends StatelessWidget {
  
  const CommonIconButton({ 
    super.key,
    this.onButtonPressed,
    this.iconData,
    this.iconSize,
    this.highlightColor,
    this.splashColor,
    this.iconColor
   });

  final VoidCallback? onButtonPressed;
  final IconData? iconData;
  final double? iconSize;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context){
    return IconButton(
      onPressed: onButtonPressed,
      icon: Icon(
        iconData ?? BoxIcons.bx_arrow_back,
        color: iconColor ?? context.currentTheme.iconTheme.color,
        size: iconSize,
      ),
      highlightColor: highlightColor,
      splashColor: highlightColor,
    );
  }
}