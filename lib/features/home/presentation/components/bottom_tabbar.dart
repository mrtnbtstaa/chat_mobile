import 'package:flutter/material.dart';
import '../../../../core/common_widgets/common_container.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/common_widgets/common_icon.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_sizes.dart';
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
    return CommonContainer(
      height: AppSizes.size64,
      padding: EdgeInsets.zero,
      boxDecoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.dBaseBackground : AppColors.lSurfaceLow
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonIcon(
                    iconData: IconMapper.getIcon(e.iconKey),
                    iconColor: e.index == currentIndex ? AppColors.primaryBrandColor : AppColors.dTextSecondary
                  ),
                  CommonText(
                    text: e.name,
                    fontColor: e.index == currentIndex ? AppColors.primaryBrandColor : AppColors.dTextSecondary,
                    fontWeight: e.index == currentIndex ? FontWeight.w700 : FontWeight.normal,
                    fontSize: AppSizes.font12,
                    letterSpacing: e.index == currentIndex ? AppSizes.size2 : AppSizes.size1,
                  )
                ]
              )
            ]
          )
        ).toList()
      )
    );
  }
}




