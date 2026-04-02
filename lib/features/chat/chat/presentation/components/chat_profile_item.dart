import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_images.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/sub_entities/chat_result_entity.dart';

class ChatProfileItem extends StatelessWidget {

  final ChatResultEntity? chatEntity;

  const ChatProfileItem({ super.key, required this.chatEntity });

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          width: context.width / 6,
          height: context.height / 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(AppImages.mountain),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: AppSizes.size16 - 2,
            height: AppSizes.size16 - 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: chatEntity?.recipient.isOnline ?? false ? AppColors.success : AppColors.error
            ),
          ),
        )
      ],
    );
  }
}