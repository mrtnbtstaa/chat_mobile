import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class WallpaperSelectionSection extends StatelessWidget {
const WallpaperSelectionSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppSizes.size24.height(),
          CommonText(
            text: "BACKGROUNDS",
          ),
          CommonText(
            text: "Wallpaper",
            fontWeight: FontWeight.w700,
            fontSize: AppSizes.size24
          ),
          AppSizes.size16.height(),
          SizedBox(
            height: 100.0,
            child: ListView.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) {
                return Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.size32),
                    image: DecorationImage(
                      image: AssetImage(AppImages.profile),
                      fit: BoxFit.cover
                    )
                  )
                );
              },
              separatorBuilder: (context, index) => Padding(padding: AppInsets.h8),
              itemCount: 5
            )
          )
        ]
      )
    );
  }
}