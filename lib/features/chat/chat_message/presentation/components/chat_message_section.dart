import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_insets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/models/chat_message_item.dart';
import 'package:flutter/material.dart';

class ChatMessageSection extends StatelessWidget {
const ChatMessageSection({ super.key });

  @override
  Widget build(BuildContext context){
    List<ChatMessageItem> items = [
      ChatMessageItem(id: "1", message: "Hello"),
      ChatMessageItem(id: "2", message: "Hi"),
      ChatMessageItem(id: "1", message: "How are you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
      ChatMessageItem(id: "2", message: "I'm fine, how about you?"),
    ];
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      primary: true,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final chat = items[index];
        return Align(
          alignment: chat.id == "1" ? Alignment.centerLeft : Alignment.centerRight,
          child: GlassContainer(
            sigmaX: chat.id == "1" ? AppSizes.size12 : AppSizes.size24,
            sigmaY: chat.id == "1" ? AppSizes.size12 : AppSizes.size24,
            colorOne: chat.id == "1" ? Colors.white.withValues(alpha: 0.2) : AppColors.bgColor.withValues(alpha: 0.2),
            colorTwo: chat.id == "1" ? Colors.white.withValues(alpha: 0.01) : AppColors.bgColor01.withValues(alpha: 0.1),
            colorThree: chat.id == "1" ? Colors.white.withValues(alpha: 0.02) : AppColors.bgColor03.withValues(alpha: 0.1),
            width: context.width / 2,
            alignmentGeometry: Alignment.centerLeft,
            padding: AppInsets.hv16,
            child: CommonText(
              text: chat.message,
            ),
          ),
        );
      },
    );
  }
}