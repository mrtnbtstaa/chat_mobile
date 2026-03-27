import 'package:chat/core/common_widgets/common_loading_indicator.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/features/chat/chat/application/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_item.dart';

class ListviewChatSection extends StatelessWidget {

  const ListviewChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          
          if(state is ChatLoading){
            return Center(
              child: CommonLoadingIndicator(),
            );
          }

          if(state is ChatConnected){
            final results = state.chatEntity?.results;
            return ListView.builder(
              padding: AppInsets.v4,
              shrinkWrap: true,
              itemCount: results?.length,
              itemBuilder: (context, index) {
                final chat = results?[index];
                return ChatItem(chatEntity: chat!);
              },
            );
          }

          return SizedBox.shrink();

        },
      ),
    );
  }
}
