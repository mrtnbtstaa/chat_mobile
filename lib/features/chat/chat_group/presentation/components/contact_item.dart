import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/enum/user_status.dart';
import '../../../../../core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common_widgets/common_cached_image.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../models/entities/group_member_entity.dart';

class ContactItem extends StatelessWidget {
  final GroupMemberEntity? groupMember;
  final Function(bool?)? onChanged;

  const ContactItem({ 
    super.key,
    required this.groupMember,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context){
    return CommonContainer(
      padding: AppInsets.a16,
      child: Row(
        spacing: AppSizes.spacing8,
        children: <Widget>[
          CommonCachedImage(
            imageUrl: groupMember?.profileAvatar ?? "",
            width: context.width / 6,
            height: context.height / 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonText(
                  text: groupMember?.fullName ?? "",
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: groupMember?.isOnline ?? false ? UserStatus.onlineStatus : UserStatus.offlineStatus,
                  fontSize: AppSizes.font14,
                  fontColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
                )
              ]
            )
          ),
          Transform.scale(
            scale: AppSizes.size1 + 0.2,
            child: Checkbox(
              value: groupMember?.isSelected,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(AppSizes.size2 + 1)
              ),
              checkColor: AppColors.lSurfaceLow,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateColor.resolveWith((_) => groupMember?.isSelected ?? false ? AppColors.primaryBrandColor : AppColors.lSurfaceMedium),
              side: BorderSide(color: Colors.transparent)
            )
          ),
        ]
      )
    );
  }
}