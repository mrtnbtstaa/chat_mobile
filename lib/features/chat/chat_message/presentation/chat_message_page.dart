import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../core/common_widgets/common_loading_indicator.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/common_widgets/common_text_field.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/style/app_colors.dart';
import '../../chat/domain/entities/sub_entities/chat_result_entity.dart';
import '../application/bloc/chat_bloc.dart';
import '../infrastructure/datasources/web_sockent_client.dart';
import 'components/chat_message_header_section.dart';
import 'components/chat_message_section.dart';
import 'components/chat_message_typing_status_section.dart';
import 'controllers/message_controller.dart';

class ChatMessagePage extends StatefulWidget {

  final ChatResultEntity chatEntity;

  const ChatMessagePage({ 
    super.key,
    required this.chatEntity
   });

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll(){
    final chatState = context.read<ChatBloc>().state;
    if(chatState is ChatConnected){
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        context.read<ChatBloc>().add(LoadMoreMessages());
      }
    }
  }

  @override
  Widget build(BuildContext context){
    final chatBloc = context.read<ChatBloc>();
    final messageController = context.read<MessageController>().messageController;
    return CommonScaffold(
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ChatMessageHeaderSection(chatResultEntity: widget.chatEntity),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if(kDebugMode){
                    print("Current socket status: ${state.status}");
                  }
                  if(state.status == SocketStatus.connecting){
                    return Expanded(child: Center(child: CommonLoadingIndicator()));
                  }else if(state.status == SocketStatus.offline){
                    return Expanded(child: Center(child: CommonLoadingIndicator(indicatorColor: AppColors.lSurfaceLow)));
                  }
                      
                  return PrimaryScrollController(
                    controller: _scrollController,
                    child: ChatMessageSection(chatMessageList: state.messages),
                  );
        
                },
              ),
        
              ChatMessageTypingStatusSection(username: widget.chatEntity.recipient.displayFullName),
        
              CommonContainer(
                padding: AppInsets.a8,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: CommonTextField(
                        suffixIconColor: AppColors.primaryBrandColor,
                        iconSuffixData: BoxIcons.bx_send,
                        onSuffixButtonPressed: (){
                          final text = messageController.text;
                          if(text.isNotEmpty){
                            chatBloc.add(SendMessage(message: text));
                            chatBloc.add(const MessageTypingChanged(""));
                            messageController.clear();
                          }
                        },
                        hintText: "Type a message...",
                        onChanged: (val) => context.read<ChatBloc>().add(MessageTypingChanged(val)),
                        controller: messageController
                      )
                    )
                  ]
                ),
              )
            ]
          )
        )
      )
    );
  }
}