import 'package:chat/features/chat/chat_group/application/bloc/chat_group_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../../core/common_widgets/common_text.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatGroupHeaderSection extends StatelessWidget {

  const ChatGroupHeaderSection({ super.key });

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
          onPressed: () => context.pushNamed(AppRoutes.chatGroupDetails, extra: context.read<ChatGroupBloc>().state.addedGroupMembers),
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero)
          ),
          child: CommonText(
            text: "Next",
            fontColor: AppColors.primaryBrandColor,
          )
        )  
      ]
    );
  }
}