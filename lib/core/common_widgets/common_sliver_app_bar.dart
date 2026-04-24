import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import '../contracts/i_user_storage.dart';
import '../di/di.dart';
import '../router/app_routes.dart';
import '../style/app_colors.dart';
import '../style/app_images.dart';
import '../style/app_insets.dart';
import '../style/app_sizes.dart';
import 'common_avatar.dart';
import 'common_cached_image.dart';
import 'common_icon_button.dart';

class CommonSliverAppBar extends StatelessWidget {


  const CommonSliverAppBar({ super.key });

  @override
  Widget build(BuildContext context){
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      title: Padding(
        padding: AppInsets.hv8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
              future: sl<IUserStorage>().getUserInfo("profile_image"),
              builder:(context, snapshot) {
                // Handle errors
                if(snapshot.hasError){
                  return const Icon(Icons.error);
                }
            
                final String? imageUrl = snapshot.data;
            
                if(imageUrl != null && imageUrl.isNotEmpty){
                  return CommonCachedImage(
                    imageUrl: imageUrl,
                    width: AppSizes.size48,
                    height: AppSizes.size48,
                  );
                }else{
                  // Fallback to placeholder image if imageUrl is null or empty
                  return CommonAvatar(path: AppImages.placeholder);
                }
              },
            ),
            Material(
              color: AppColors.primaryBrandColor,
              borderRadius: BorderRadius.circular(AppSizes.size8),
              child: CommonIconButton(
                onButtonPressed: () => context.pushNamed(AppRoutes.chatGroup),
                iconData: FontAwesome.user_plus_solid,
                iconSize: AppSizes.size24 - 4,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconColor: AppColors.lSurfaceLow,
              ),
            )
          ],
        ),
      ),
    );
  }
}

