import 'package:chat/core/common_widgets/common_divider.dart';
import 'package:chat/core/extensions/string_extension.dart';
import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatItem extends StatelessWidget {

  const ChatItem({ 
    super.key,
    required this.chatEntity,
  });

  final ChatResultEntity chatEntity;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ListTile(
          onTap: () {
            context.pushNamed(AppRoutes.chatMessage, extra: chatEntity);
          },
          leading: Stack(
            alignment: Alignment.topCenter,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.profile),
                radius: 20,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CommonContainer(
                  clip: Clip.hardEdge,
                  width: 12.0,
                  height: 12.0,
                  boxDecoration: BoxDecoration(
                    color: chatEntity.recipient.isOnline ?AppColors.accentColor : AppColors.errorRed,
                    shape: BoxShape.circle
                  )
                )
              )
            ]
          ),
          title: CommonText(text: chatEntity.recipient.displayFullName.capitalize),
          subtitle: CommonText(
            text: "${chatEntity.recipient.username}: ${chatEntity.lastMessage?.text ?? 'Start a conversation'}",
            wrap: true,
            textOverflow: TextOverflow.ellipsis,
          ),
          trailing: Stack(
            clipBehavior: Clip.none,
            children: [
              CommonText(text: chatEntity.lastMessage?.lastMessageAt ?? ""),
              chatEntity.unreadCount != 0 ?
              Positioned(
                right: -AppSizes.size8,
                top: -AppSizes.size16 - 2,
                child: CommonContainer(
                  width: AppSizes.size16 + 4,
                  height: AppSizes.size16 + 4,
                  clip: Clip.none,
                  boxDecoration: BoxDecoration(
                    color: AppColors.errorRed,
                    shape: BoxShape.circle
                  ),
                  child: CommonText(text: chatEntity.unreadCount.toString()),
                )
              )
              : SizedBox.shrink()
            ]
          )
        ),
        CommonDivider()
      ],
    );
  }
}