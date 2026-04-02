import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/datetime_extension.dart';

import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/sub_entities/chat_result_entity.dart';

class ChatConversationItem extends StatelessWidget {

  final ChatResultEntity? chatEntity;

  const ChatConversationItem({ super.key, required this.chatEntity });

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              spacing: AppSizes.size2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CommonText(
                      text: chatEntity?.recipient.displayFullName ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.font16,
                    ),
                    Padding(
                      padding: AppInsets.h16,
                      child: CommonText(
                        text: chatEntity?.lastMessage?.lastMessageAt?.formatRelativeTime() ?? "",
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
                      )
                    )
                  ]
                ),
                Padding(
                  padding: EdgeInsets.only(right: AppSizes.size16),
                  child: CommonText(
                    text: chatEntity?.lastMessage?.text ?? "",
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}