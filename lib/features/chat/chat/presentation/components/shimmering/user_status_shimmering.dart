import 'package:flutter/widgets.dart';
import '../../../../../../core/common_widgets/common_container.dart';
import '../../../../../../core/common_widgets/common_shimmer_animator.dart';
import '../../../../../../core/common_widgets/common_text_shimmering.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/app_sizes.dart';

class UserStatusShimmering extends StatelessWidget {
const UserStatusShimmering({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonShimmerAnimator(
      child: Column(
        spacing: AppSizes.spacing8,
        children: [
          AppSizes.size16.height(),
          CommonContainer(
            padding: EdgeInsets.zero,
            width: context.width / 5,
            height: context.height / 11,
            boxDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.currentTheme.cardTheme.color?.withValues(alpha: 0.8)
            )
          ),
          CommonTextShimmering()
        ]
      )
    );
  }
}