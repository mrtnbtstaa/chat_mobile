import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/style/app_colors.dart';

import '../../../core/common_widgets/animated_background.dart';
import '../../../core/common_widgets/common_container.dart';
import '../../../core/common_widgets/common_scaffold.dart';
import '../../../core/extensions/context_extension.dart';
import 'components/staggered_three_dot_loader.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
const SplashPage({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          CommonContainer(
            width: context.width,
            height: context.height,
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CommonText(text: "Chat v2.0", fontColor: AppColors.primaryBrandColor)
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedBackground()
          ),
          Positioned.fill(
            child: StaggeredThreeDotLoader()
          ),
          
        ],
      ),
    );
  }
}


