import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_label_divider.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import 'register_now_content.dart';
import 'package:flutter/widgets.dart';

class SocialAuthSection extends StatelessWidget {
const SocialAuthSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      spacing: AppSizes.size16,
      children: <Widget>[
        AppSizes.size16.height(),
        CommonLabelDivider(),
        CommonElevatedButton(
          withIcon: true,
          width: context.width,
          height: AppSizes.size64,
          text: "Sign in with Google",
          elevatedPadding: AppInsets.h4,
          onButtonPressed: (){},
          fontColor: AppColors.ltextPrimary,
          boxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.size16),
            color: AppColors.lSurfaceLow
          ),
        ),
        RegisterNowContent(),
      ],
    );
  }
}