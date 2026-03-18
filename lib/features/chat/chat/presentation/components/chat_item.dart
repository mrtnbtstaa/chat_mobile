import 'package:chat/core/common_widgets/common_divider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatItem extends StatelessWidget {

  const ChatItem({ 
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        ListTile(
          onTap: () => context.pushNamed(AppRoutes.chatMessage),
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.profile),
                radius: 20,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CommonContainer(
                  clip: Clip.hardEdge,
                  width: 12.0,
                  height: 12.0,
                  boxDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle
                  )
                )
              )
            ]
          ),
          title: CommonText(text: "John Doe"),
          subtitle: CommonText(
            text: "Hello world qwewqewqeqweqwewqeqwewqeqwewqeqwewqewqe",
            wrap: true,
            textOverflow: TextOverflow.ellipsis,
          ),
          trailing: Stack(
            clipBehavior: Clip.none,
            children: [
              CommonText(text: "09:30 PM"),
              Positioned(
                right: -AppSizes.size8,
                top: -AppSizes.size16 - 2,
                child: CommonContainer(
                  width: AppSizes.size16 + 4,
                  height: AppSizes.size16 + 4,
                  clip: Clip.none,
                  boxDecoration: BoxDecoration(
                    color: AppColors.errorRed,
                    shape: BoxShape.circle
                  ),
                  child: CommonText(text: "2"),
                )
              )
            ]
          )
        ),
        CommonDivider()
      ],
    );
  }
}