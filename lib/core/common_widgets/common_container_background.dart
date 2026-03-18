import 'common_container.dart';
import '../style/app_images.dart';
import '../extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CommonContainerBackground extends StatelessWidget {
const CommonContainerBackground({ super.key });

  @override
  Widget build(BuildContext context){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CommonContainer(
          height: context.height,
          boxDecoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.mountain),
            )
          ),
        ),
        ColoredBox(color: Colors.black.withValues(alpha: 0.25))
      ],
    );
  }
}