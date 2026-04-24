import 'package:chat/core/enum/user_status.dart';

import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../application/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/common_widgets/status_indicator.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../chat/domain/entities/sub_entities/chat_result_entity.dart';
import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatMessageHeaderSection extends HookWidget {
  final ChatResultEntity chatResultEntity;

  const ChatMessageHeaderSection({super.key, required this.chatResultEntity});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    return Column(
      children: <Widget>[
        Padding(
          padding: AppInsets.a8,
          child: Row(
            spacing: AppSizes.size8,
            children: <Widget>[
              CommonIconButton(onButtonPressed: () => context.pop()),
              CommonAvatar(path: AppImages.profile),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.isSearchEnable) {
                    return Expanded(
                      child: CommonTextField(
                        hintText: "Search messages...",
                        width: context.width,
                        height: AppSizes.size48,
                        onChanged: (val) {},
                        controller: searchController,
                        onSuffixButtonPressed: (){},
                        iconSuffixData: BoxIcons.bx_search_alt,
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: chatResultEntity.recipient.displayFullName.capitalize,
                          fontSize: AppSizes.font16,
                          fontWeight: FontWeight.w600,
                        ),
                        Row(
                          spacing: AppSizes.spacing4,
                          children: <Widget>[
                            StatusIndicator(
                              size: AppSizes.size8,
                              indicatorColor:
                                  chatResultEntity.recipient.isOnline
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                            CommonText(
                              text: chatResultEntity.recipient.isOnline ? UserStatus.onlineStatus : UserStatus.offlineStatus,
                              fontColor: AppColors.primaryBrandColor,
                            )
                          ]
                        )
                      ]
                    )
                  );
                }
              ),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return CommonIconButton(
                    onButtonPressed: () => context.read<ChatBloc>().add(SearchEnabled()),
                    iconData: state.isSearchEnable ? BoxIcons.bx_x : BoxIcons.bx_search,
                    iconColor: AppColors.primaryBrandColor,
                  );
                }
              )
            ]
          )
        )
      ]
    );
  }
}
