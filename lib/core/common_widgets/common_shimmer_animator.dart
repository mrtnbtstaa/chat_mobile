import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../extensions/int_extension.dart';

class CommonShimmerAnimator extends StatefulWidget {
  final Widget child; 
  const CommonShimmerAnimator({ super.key, required this.child });

  @override
  ShimmerAnimatorState createState() => ShimmerAnimatorState();
}

class ShimmerAnimatorState extends State<CommonShimmerAnimator> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: 1500.milliseconds()
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback:(bounds) {
              return LinearGradient(
                begin: Alignment(-1.0 + (2 * _controller.value), 0),
                end: Alignment(1.0 + (2 * _controller.value), 0),
                stops: const [0.1, 0.25, 0.35],
                colors: [
                  AppColors.lSurfaceLow,
                  const Color.fromARGB(255, 255, 255, 255),
                  AppColors.lSurfaceLow,
                ]
              )
              .createShader(bounds);
            },
            child: widget.child,
          );
        },
      ),
    );
  }
}