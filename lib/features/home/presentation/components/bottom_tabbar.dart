import 'package:flutter/material.dart';

import '../../../../core/common_widgets/common_icon.dart';
import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_sizes.dart';
import '../../../../core/extensions/int_extension.dart';
import '../mappers/icon_mapper.dart';
import 'bottom_tabbar_constants.dart';

class BottomTabbar extends StatelessWidget {

  const BottomTabbar({ 
    super.key,
    required this.controller,
    required this.currentIndex
   });

  final TabController controller;
  final int currentIndex;

  @override
  Widget build(BuildContext context){
    return GlassContainer(
      height: AppSizes.size64,
      borderRadiusGeometry: BorderRadius.only(
        topLeft: Radius.circular(AppSizes.size24),
        topRight: Radius.circular(AppSizes.size24)
      ),
      child: TabBar(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        tabAlignment: TabAlignment.fill,
        padding: EdgeInsets.zero,
        indicatorAnimation: TabIndicatorAnimation.elastic,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        tabs: BottomTabbarConstants.items.map(
          (e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedContainer(
                duration: 150.milliseconds(),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(
                  0,
                  e.index == currentIndex ? -AppSizes.size2 : 0,
                  0
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -7,
                      child: AnimatedContainer(
                        duration: 200.milliseconds(),
                        height: 2.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          color: e.index == currentIndex ? AppColors.circleColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppSizes.size8)
                        ),
                      ),
                    ),
                    CommonIcon(
                      iconData: IconMapper.getIcon(e.iconKey),
                      iconColor: e.index == currentIndex ? AppColors.primaryTextColor : AppColors.primaryTextColor.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              )
            ],
          )
        ).toList(),
      ),
    );
  }
}




