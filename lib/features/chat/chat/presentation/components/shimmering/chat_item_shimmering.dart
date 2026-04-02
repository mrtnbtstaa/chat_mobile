import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/extensions/context_extension.dart';

import '../../../../../../core/common_widgets/common_shimmer_animator.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';
import 'chat_conversation_item_shimmering.dart';
import 'chat_profile_item_shimmering.dart';
import 'package:flutter/material.dart';


class ChatItemShimmering extends StatelessWidget {

  const ChatItemShimmering({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.size8,
      children: <Widget>[
        CommonShimmerAnimator(
          child: CommonContainer(
            boxDecoration: BoxDecoration(
              color: context.currentTheme.cardTheme.color?.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppSizes.size16),
            ),
            padding: AppInsets.a8,
            child: Row(
              spacing: AppSizes.spacing16,
              children: <Widget>[
                CommonShimmerAnimator(child: ChatProfileItemShimmering()),
                ChatConversationItemShimmering()
              ]
            )
          ),
        )
      ]
    );
  }
}