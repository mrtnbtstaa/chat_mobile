import 'package:chat/core/common_widgets/common_container.dart';

import '../../../../../../core/common_widgets/common_text.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class MemberHeaderContent extends StatelessWidget {

  final int memberCount;

  const MemberHeaderContent({ super.key, required this.memberCount });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonText(
          text: "Members",
          fontSize: AppSizes.font16,
          fontWeight: FontWeight.w700,
        ),
        CommonContainer(
          padding: AppInsets.a8,
          child: CommonText(text: "$memberCount SELECTED", fontSize: AppSizes.font12),
        ),
      ],
    );
  }
}