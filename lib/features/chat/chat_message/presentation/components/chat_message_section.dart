import 'dart:ui';

import 'package:chat/core/common_widgets/common_loading_indicator.dart';
import 'package:chat/core/extensions/datetime_extension.dart';
import 'package:chat/core/extensions/double_extension.dart';
import 'package:chat/features/chat/chat_message/application/bloc/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_message_entity.dart';

import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ChatMessageSection extends StatelessWidget {

  final List<ChatMessageEntity> chatMessageList;

  const ChatMessageSection({ 
    super.key,
    required this.chatMessageList
  });

  @override
  Widget build(BuildContext context){
    final state = context.read<ChatBloc>().state;
    return Expanded(
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        primary: true,
        reverse: true,
        // shrinkWrap: true,
        itemCount: chatMessageList.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          
          // Show the loading indicator if we are loading more data and 
          if(index == chatMessageList.length && state.isLoadingMore){
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CommonLoadingIndicator()),
            );
          }
      
          final chat = chatMessageList[index];
          final chatDate = chat.createdAt;
      
          bool showDateHeader = false;
      
          // Get the older message, or null if its the end of the list
          final previousChat = (index + 1 < chatMessageList.length) ? chatMessageList[index + 1] : null;
      
          if(previousChat == null || !DateUtils.isSameDay(chatDate, previousChat.createdAt)){showDateHeader = true;}
      
          return Column(
            children: [
              AppSizes.size8.height(),
              if(showDateHeader)
              GlassContainer(
                padding: AppInsets.a8,
                child: CommonText(
                  text: chatDate.getGroupDate()
                )
              ),
              Align(
                alignment: chat.sentByMe ? Alignment.centerLeft : Alignment.centerRight,
                child: GlassContainer(
                  borderRadiusGeometry: chat.sentByMe ? BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.size16),
                    topRight: Radius.circular(AppSizes.size16),
                    bottomLeft: Radius.circular(AppSizes.size16),
                  ) : BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.size16),
                    topRight: Radius.circular(AppSizes.size16),
                    bottomRight: Radius.circular(AppSizes.size16),
                  ),
                  sigmaX: AppSizes.size24,
                  sigmaY: AppSizes.size24,
                  colorOne: chat.sentByMe ? Colors.white.withValues(alpha: 0.2) : AppColors.bgColor.withValues(alpha: 0.2),
                  colorTwo: chat.sentByMe ? Colors.white.withValues(alpha: 0.01) : AppColors.bgColor01.withValues(alpha: 0.1),
                  colorThree: chat.sentByMe ? Colors.white.withValues(alpha: 0.02) : AppColors.bgColor03.withValues(alpha: 0.1),
                  width: context.width / 2,
                  alignmentGeometry: Alignment.centerLeft,
                  padding: AppInsets.hv16,
                  child: CommonText(text: chat.content)
                )
              ),
            ],
          );
        },
      ),
    );
  }
}