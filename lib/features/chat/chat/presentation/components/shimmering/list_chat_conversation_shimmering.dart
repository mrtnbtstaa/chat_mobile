import '../../../../../../core/common_widgets/common_text.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/app_sizes.dart';
import '../../../../../../core/style/app_insets.dart';
import 'chat_item_shimmering.dart';
import 'package:flutter/material.dart';

class ListChatConversationShimmering extends StatelessWidget {
const ListChatConversationShimmering({ super.key });

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Column(
        spacing: AppSizes.size8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppSizes.size8.height(),
          CommonText(
            text: "RECENT CONVERSATIONS",
            fontWeight: FontWeight.w600,
          ),
          Expanded(
            child: ListView.separated(
              padding: AppInsets.v4,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return ChatItemShimmering();
              },
              separatorBuilder: (context, index) => Padding(padding: AppInsets.v8)
            ),
          )
        ],
      )
    );
  }
}