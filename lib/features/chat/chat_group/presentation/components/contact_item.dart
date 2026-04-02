import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class ContactItem extends StatelessWidget {
  
  final String username;
  final String avatar;
  final String status;
  final Function(bool?)? onChanged;
  final bool isSelected;

  const ContactItem({ 
    super.key,
    required this.username,
    required this.avatar,
    required this.status,
    required this.onChanged,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context){
    return CommonContainer(
      padding: AppInsets.a16,
      child: Row(
        spacing: AppSizes.spacing8,
        children: <Widget>[
          CommonAvatar(
            path: avatar,
            radius_: AppSizes.size24
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonText(
                  text: username,
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: status,
                  fontSize: AppSizes.font14,
                  fontColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
                )
              ]
            )
          ),
          Transform.scale(
            scale: AppSizes.size1 + 0.2,
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(AppSizes.size2 + 1)
              ),
              checkColor: AppColors.lSurfaceLow,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateColor.resolveWith((_) => isSelected ? AppColors.primaryBrandColor : AppColors.lSurfaceMedium),
              side: BorderSide(color: Colors.transparent)
            )
          ),
        ]
      )
    );
  }
}