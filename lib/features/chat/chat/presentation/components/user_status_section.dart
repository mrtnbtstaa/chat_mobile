import 'package:chat/core/common_widgets/common_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../application/bloc/chat_bloc.dart';
import 'shimmering/user_status_shimmering.dart';

class UserStatusSection extends StatelessWidget {
  const UserStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ChatBloc>();
    final results = bloc.state.chatUserEntity?.results;
    return BlocBuilder<ChatBloc, ChatState>(
      // buildWhen: (previous, current) => previous.chatUserEntity?.results.length != current.chatUserEntity?.results.length,
      builder: (context, state) {

        if(state is ChatLoading){
          return SizedBox(
            height: context.height / 7.5 + AppSizes.size16,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UserStatusShimmering(),
              separatorBuilder: (context, index) => Padding(padding: AppInsets.a8),
              itemCount: 4
            ),
          );
        }

        if(state is ChatError){
          return SizedBox(
            height: context.height / 7.5 + AppSizes.size16,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UserStatusShimmering(),
              separatorBuilder: (context, index) => Padding(padding: AppInsets.a8),
              itemCount: 4
            ),
          );
        }

        return Column(
          children: <Widget>[
            AppSizes.size16.height(),
            SizedBox(
              height: context.height / 7.5 + AppSizes.size16,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppInsets.v8,
                itemCount: results?.length ?? 0,
                itemBuilder: (context, index) {
                  final chat = results?[index];
                  return Column(
                    spacing: AppSizes.spacing8,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () => context.pushNamed(
                              AppRoutes.chatMessage,
                              extra: chat,
                            ),
                            child: CommonCachedImage(
                              imageUrl: chat?.recipient.profileImage ?? "",
                              width: context.width / 5,
                              height: context.height / 13,
                              radius: AppSizes.size32,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: chat?.recipient.profileImage?.isNotEmpty ?? false ? 10 : 3,
                            child: Container(
                              width: AppSizes.size16 - 2,
                              height: AppSizes.size16 - 2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: chat?.recipient.isOnline ?? false ? AppColors.success : AppColors.error,
                              )
                            )
                          )
                        ]
                      ),
                      CommonText(
                        text: chat?.recipient.displayFullName.firstname.capitalize ?? "",
                        fontWeight: FontWeight.w600,
                      )
                    ]
                  );
                },
                separatorBuilder: (context, index) => Padding(padding: AppInsets.a8)
              )
            )
          ]
        );
      }
    );
  }
}
