import 'package:chat/core/common_widgets/common_container.dart';
import 'package:flutter/widgets.dart';
import '../../../../../../core/extensions/context_extension.dart';


class ChatProfileItemShimmering extends StatelessWidget {


  const ChatProfileItemShimmering({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonContainer(
      width: context.width / 6,
      height: context.height / 14,
      boxDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.currentTheme.cardTheme.color?.withValues(alpha: 0.8)
      ),
    );
  }
}