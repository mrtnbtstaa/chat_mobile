import 'package:flutter/widgets.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatBubble extends StatelessWidget {

  final bool isMe;
  final String content;
  final String dateSent;

  const ChatBubble({ 
    super.key,
    required this.isMe,
    required this.content,
    required this.dateSent
   });

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: AppInsets.a16,
        child: Column(
          spacing: AppSizes.spacing8,
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            CommonContainer(
              backgroundColor: isMe ? AppColors.primaryBrandColor : AppColors.dSurfaceMedium,
              child: CommonText(
                text: content,
                fontColor: AppColors.dTextPrimary,
              ),
            ),
            CommonText(
              text: dateSent,
              fontSize: AppSizes.font12,
            )
          ],
        ),
      )
    );
  }
}