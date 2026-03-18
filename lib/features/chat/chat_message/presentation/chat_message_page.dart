import 'package:flutter/material.dart';

import '../../../../core/common_widgets/common_text_field.dart';
import '../../../../core/style/app_sizes.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../core/common_widgets/glass_container.dart';
import 'components/chat_message_header_section.dart';
import 'components/chat_message_section.dart';
import '../../../../core/common_widgets/common_container_background.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/extensions/context_extension.dart';

class ChatMessagePage extends StatelessWidget {
const ChatMessagePage({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.topCenter,
          children: <Widget>[
            CommonContainerBackground(),
            GlassContainer(
              sigmaX: AppSizes.size2,
              sigmaY: AppSizes.size2,
              height: context.height,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    ChatMessageHeaderSection(),
                    Expanded(
                      child: PrimaryScrollController(
                        controller: ScrollController(),
                        child: ChatMessageSection()
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CommonTextField(
                            hasSuffixIcon: true,
                            iconSuffixData: BoxIcons.bx_send,
                            onSuffixButtonPressed: (){},
                            hintText: "Type a message...",
                            onChanged: (val){},
                            controller: TextEditingController()
                          ),
                        )
                      ],
                    )
                  ]
                )
              ),
            ),
          ]
        ),
      )
    );
  }
}