import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/common_widgets/status_indicator.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../chat/domain/entities/sub_entities/chat_result_entity.dart';
import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatMessageHeaderSection extends StatelessWidget {

  final ChatResultEntity chatResultEntity;

  const ChatMessageHeaderSection({ 
    super.key,
    required this.chatResultEntity
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          padding: AppInsets.a8,
          child: Row(
            spacing: AppSizes.size8,
            children: <Widget>[
              CommonIconButton(onButtonPressed: () => context.pop()),
              CommonAvatar(path: AppImages.profile),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: chatResultEntity.recipient.displayFullName.capitalize,
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      spacing: AppSizes.spacing4,
                      children: <Widget>[
                        StatusIndicator(
                          size: AppSizes.size8,
                          indicatorColor: chatResultEntity.recipient.isOnline ? AppColors.success : AppColors.error,
                        ),
                        CommonText(
                          text: chatResultEntity.recipient.isOnline ? "Online" : "Offline",
                          fontColor: AppColors.primaryBrandColor,
                        )
                      ]
                    ),
                  ]
                ),
              ),
              CommonIconButton(
                onButtonPressed: (){},
                iconData: BoxIcons.bx_search,
                iconColor: AppColors.primaryBrandColor,
              )
            ]
          )
        ),
      ]
    );
  }
}