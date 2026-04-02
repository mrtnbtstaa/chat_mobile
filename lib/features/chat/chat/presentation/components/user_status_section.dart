import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../application/bloc/chat_bloc.dart';
import 'shimmering/user_status_shimmering.dart';

class UserStatusSection extends StatelessWidget {
  const UserStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ChatBloc>();
    final results = bloc.state.chatEntity?.results;
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
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
                            child: Container(
                              width: context.width / 5,
                              height: context.height / 11,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(AppImages.mountain),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: context.isDarkMode
                                      ? AppColors.dSurfaceMedium
                                      : AppColors.lSurfaceLow,
                                  width: AppSizes.size4 - 1,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 10,
                            child: Container(
                              width: AppSizes.size16 - 2,
                              height: AppSizes.size16 - 2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: chat?.recipient.isOnline ?? false
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CommonText(
                        text: chat?.recipient.displayFullName.firstname ?? "",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    Padding(padding: AppInsets.a8),
              ),
            ),
          ],
        );
      },
    );
  }
}
