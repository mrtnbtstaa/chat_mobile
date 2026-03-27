import 'package:flutter/material.dart';

import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/style/app_sizes.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/common_widgets/common_container_background.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import 'components/chat_header_section.dart';
import 'components/listview_chat_section.dart';

class ChatContent extends StatelessWidget {
const ChatContent({ super.key });

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: <Widget>[
            CommonContainerBackground(),
            GlassContainer(
              borderRadiusGeometry: BorderRadius.circular(0.0),
              sigmaX: AppSizes.size2,
              sigmaY: AppSizes.size2,
              height: context.height,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    ChatHeaderSection(
                      onSearchTap: () {},
                      onGroupTap: () {}
                    ),
                    ListviewChatSection(),
                  ]
                )
              ),
            )
          ]
        )
      )
    );
  }
}
