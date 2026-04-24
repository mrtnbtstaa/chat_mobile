import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../domain/entities/sub_entities/chat_result_entity.dart';
import 'chat_conversation_item.dart';
import 'chat_profile_item.dart';

class ChatItem extends StatelessWidget {

  const ChatItem({ 
    super.key,
    required this.chatEntity,
  });

  final ChatResultEntity? chatEntity;

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.size8,
      children: <Widget>[
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.chatMessage, extra: chatEntity),
          child: CommonContainer(
            padding: AppInsets.a8,
            borderRadius: AppSizes.size16,
            child: Row(
              spacing: AppSizes.spacing16,
              children: <Widget>[
                ChatProfileItem(chatEntity: chatEntity),
                ChatConversationItem(chatEntity: chatEntity)
              ]
            )
          ),
        ),
      ]
    );
  }
}