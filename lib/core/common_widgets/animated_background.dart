import 'background_painter.dart';
import '../extensions/int_extension.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
const AnimatedBackground({ super.key });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: 5.seconds());

    _animation = Tween<double>(
      begin: 100,
      end: 150
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(offset: _animation.value),
        );
      },
    );
  }
}