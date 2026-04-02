import 'package:chat/core/common_widgets/common_shimmer_animator.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:flutter/widgets.dart';
import '../../../../../../core/common_widgets/common_text_shimmering.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';


class ChatConversationItemShimmering extends StatelessWidget {


  const ChatConversationItemShimmering({ super.key });

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: CommonShimmerAnimator(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                spacing: AppSizes.size8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CommonTextShimmering(
                        width: context.width / 4,
                      ),
                      Padding(
                        padding: AppInsets.h16,
                        child: CommonTextShimmering()
                      )
                    ]
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: AppSizes.size16),
                    child: CommonTextShimmering(
                      width: context.width / 2
                    )
                  )
                ]
              )
            )
          ]
        ),
      )
    );
  }
}