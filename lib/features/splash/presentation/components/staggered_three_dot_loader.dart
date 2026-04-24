import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/features/splash/presentation/components/staggered_dot_painter.dart';
import 'package:flutter/material.dart';

class StaggeredThreeDotLoader extends StatefulWidget {
const StaggeredThreeDotLoader({ super.key });

  @override
  State<StaggeredThreeDotLoader> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<StaggeredThreeDotLoader> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: 1.seconds());

    _dotAnimations = List.generate(3, (i){
      double start = i * 0.2; // 0.0 -> 0.2 -> 0.4
      double end = (start + 0.6).clamp(0.0, 1.0);

      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeInSine)
      );

    });

    _controller.repeat();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: StaggeredDotPainter(
              animations: _dotAnimations,
            ),
          );
        }
      ),
    );
  }
}