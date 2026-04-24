import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_cached_image.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/contracts/i_user_storage.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../application/bloc/profile_bloc.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          elevation: 8.0,
          shape: CircleBorder(),
          shadowColor: Colors.black.withValues(alpha: 0.5),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if(state is ProfileError){}
              return Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.read<ProfileBloc>().add(UploadProfile()),
                    child: FutureBuilder(
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
                            width: AppSizes.size140,
                            height: AppSizes.size140,
                          );
                        }else{
                          // Fallback to placeholder image if imageUrl is null or empty
                          return CommonAvatar(path: AppImages.placeholder, radius_: AppSizes.size72);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () => context.read<ProfileBloc>().add(UploadProfile()),
                      child: CommonContainer(
                        padding: AppInsets.a8,
                        boxDecoration: BoxDecoration(
                          color: AppColors.primaryBrandColor,
                          shape: BoxShape.circle,
                        ),
                        child: CommonIcon(
                          iconData: Iconsax.camera_bold,
                          iconColor: AppColors.lSurfaceLow,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        AppSizes.spacing8.height(),
        FutureBuilder(
          future: sl<IUserStorage>().getUserInfo("full_name"),
          builder: (context, asyncSnapshot) {

            if(asyncSnapshot.hasError){
              return CommonText(text: "No name found");
            }

            return CommonText(
              text: asyncSnapshot.data ?? "",
              fontWeight: FontWeight.w800,
              fontSize: AppSizes.font24,
            );
          }
        ),
        AppSizes.size32.height(),
      ],
    );
  }
}


// Container(
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     border: Border.all(
//       color: AppColors.lSurfaceLow,
//       width: AppSizes.size4,
//     ),
//   ),
//   child: CommonAvatar(
//     path: state.imagePath ?? AppImages.profile,
//     radius_: AppSizes.size72,
//   ),
// )