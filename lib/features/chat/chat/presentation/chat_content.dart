import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/style/app_insets.dart';
import '../../../../core/style/app_sizes.dart';
import 'components/list_chat_conversation_section.dart';
import 'components/search_section.dart';
import 'components/user_status_section.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocus(),
      child: Padding(
        padding: AppInsets.h24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppSizes.size16.height(),
            SearchSection(),
            UserStatusSection(),
            ListChatConversationSection(),
          ],
        ),
      ),
    );
  }
}
