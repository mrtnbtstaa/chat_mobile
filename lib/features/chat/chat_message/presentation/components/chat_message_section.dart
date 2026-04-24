import 'chat_bubble.dart';
import 'package:flutter/material.dart';
import '../../application/bloc/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/extensions/datetime_extension.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_loading_indicator.dart';

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
        itemCount: chatMessageList.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          
          // Show the loading indicator if we are loading more data
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

          bool sentByMe = chat.messageRecipient.sentByMe;
      
          return Column(
            children: [
              AppSizes.size8.height(),
              if(showDateHeader)
              CommonContainer(
                padding: AppInsets.a8,
                child: CommonText(
                  text: chatDate.getGroupDate()
                ),
              ),
              ChatBubble(
                isMe: sentByMe,
                content: chat.content,
                dateSent: chat.createdAt.formattedTime(),
              )
            ]
          );
        }
      )
    );
  }
}