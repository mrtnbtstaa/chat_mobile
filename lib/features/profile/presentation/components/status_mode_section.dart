import 'package:chat/core/common_widgets/common_container.dart';

import '../../../../core/common_widgets/common_animated_switcher.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_insets.dart';
import '../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class StatusModeSection extends StatelessWidget {
const StatusModeSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h32,
      child: CommonContainer(
        padding: AppInsets.a16,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonText(
                    text: "Stealth Mode",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font16,
                  ),
                  CommonText(
                    text: "Hide your online status from others",
                  )
                ],
              ),
            ),
            CommonAnimatedSwitcher(
              duration: 2.seconds(),
              value: false,
              onChanged: (val){}
            )
          ],
        ),
      ),
    );
  }
}