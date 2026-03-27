import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/features/chat/chat_message/application/bloc/chat_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageTypingStatusSection extends StatelessWidget {

  final String username;

  const ChatMessageTypingStatusSection({ 
    super.key,
    required this.username
   });

  @override
  Widget build(BuildContext context){
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.typingUsername != current.typingUsername,
      builder: (context, state) {
        if(kDebugMode){
          print("Current state iqwewqe: ${state.status}, ${username == state.typingUsername}");
        }
        return Align(
          alignment: username.toLowerCase() == state.typingUsername?.toLowerCase() ? Alignment.centerLeft : Alignment.centerRight,
          child: AnimatedContainer(
            duration: 300.milliseconds(),
            height: state.typingUsername != null ? 20 : 0,
            padding: EdgeInsets.only(left: AppSizes.size16),
            child: state.typingUsername != null ?
            CommonText(
              text: "${state.typingUsername} is typing..."
            ) : SizedBox.shrink()
          )
        );
      },
    );
  }
}