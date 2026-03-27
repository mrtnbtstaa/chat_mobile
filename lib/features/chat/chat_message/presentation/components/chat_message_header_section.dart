import 'package:chat/core/common_widgets/status_indicator.dart';
import 'package:chat/core/extensions/string_extension.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_result_entity.dart';
import 'package:flutter/material.dart';

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
    return GlassContainer(
      borderRadiusGeometry: BorderRadius.circular(0.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: AppInsets.a8,
            child: Row(
              spacing: AppSizes.size8,
              children: <Widget>[
                CommonIconButton(),
                CommonAvatar(path: AppImages.profile),
                Column(
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
                          indicatorColor: chatResultEntity.recipient.isOnline ? AppColors.accentColor : AppColors.errorRed,
                        ),
                        CommonText(text: chatResultEntity.recipient.isOnline ? "Online" : "Offline")
                      ],
                    )
                  ],
                ),
              ]
            ),
          ),
        ]
      )
    );
  }
}