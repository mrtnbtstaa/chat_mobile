import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/features/chat/chat/application/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_item.dart';
import 'shimmering/list_chat_conversation_shimmering.dart';

class ListChatConversationSection extends StatelessWidget {
  const ListChatConversationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ChatBloc>();
    final results = bloc.state.chatEntity?.results;
    print("List chat conversation Len: ${results?.length}");
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {

        if(state is ChatLoading) return ListChatConversationShimmering();
        if(state is ChatError) return ListChatConversationShimmering();

        return Expanded(
          child: Column(
            spacing: AppSizes.size8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "RECENT CONVERSATIONS",
                fontWeight: FontWeight.w600,
              ),
              Expanded(
                child: ListView.separated(
                  padding: AppInsets.v4,
                  shrinkWrap: true,
                  itemCount: results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final chat = results?[index];
                    return ChatItem(chatEntity: chat);
                  },
                  separatorBuilder: (context, index) => Padding(padding: AppInsets.v8)
                )
              )
            ]
          )
        );
      }
    );
  }
}
