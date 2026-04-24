import 'package:flutter/widgets.dart';
import '../../../../../core/common_widgets/common_cached_image.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../domain/entities/sub_entities/chat_result_entity.dart';

class ChatProfileItem extends StatelessWidget {

  final ChatResultEntity? chatEntity;

  const ChatProfileItem({ super.key, required this.chatEntity });

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        CommonCachedImage(imageUrl: chatEntity?.recipient.profileImage ?? ""),
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