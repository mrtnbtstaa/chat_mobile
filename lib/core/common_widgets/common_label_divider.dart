import 'package:chat/core/common_widgets/common_divider.dart';
import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/widgets.dart';

class CommonLabelDivider extends Row{

  final String? text;

  CommonLabelDivider({
    super.key,
    this.text
  }) : super(
    spacing: AppSizes.size16,
    children: [
      Expanded(
        child: CommonDivider(
          indent_: AppSizes.size8,
        )
      ),
      CommonText(
        text: text ?? "OR CONTINUE WITH",
        fontSize: AppSizes.font12,
        fontWeight: FontWeight.w600,
      ),
      Expanded(
        child: CommonDivider(
          endIndent_: AppSizes.size8,
        )
      ),
    ]
  );
}