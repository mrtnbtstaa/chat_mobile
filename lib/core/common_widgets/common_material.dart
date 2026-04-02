import 'package:chat/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonMaterial extends StatelessWidget {

  final Widget child;

  const CommonMaterial({ super.key, required this.child });

  @override
  Widget build(BuildContext context){
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: Material(
        color: context.currentTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        child: child,
      ),
    );
  }
}

