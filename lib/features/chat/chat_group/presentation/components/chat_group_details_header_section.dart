import '../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatGroupDetailsHeaderSection extends StatelessWidget {
const ChatGroupDetailsHeaderSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        CommonIconButton(
          onButtonPressed: context.pop,
        ),
        Expanded(
          child: CommonText(
            text: "New Group",
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.font14,
          )
        ),
        TextButton(
          onPressed: (){},
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero)
          ),
          child: CommonText(
            text: "Create",
            fontColor: AppColors.primaryBrandColor,
          )
        )  
      ]
    );
  }
}