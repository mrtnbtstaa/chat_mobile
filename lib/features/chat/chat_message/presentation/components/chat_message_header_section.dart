import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatMessageHeaderSection extends StatelessWidget {

  const ChatMessageHeaderSection({ 
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return GlassContainer(
      borderRadiusGeometry: BorderRadius.circular(0.0),
      child: Column(
        spacing: AppSizes.size16,
        children: <Widget>[
          Padding(
            padding: AppInsets.a8,
            child: Row(
              spacing: AppSizes.size8,
              children: <Widget>[
                CommonIconButton(),
                CommonAvatar(path: AppImages.profile),
                CommonText(
                  text: "John Doe",
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w600,
                )
              ]
            ),
          )
        ]
      )
    );
  }
}