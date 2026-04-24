import 'package:chat/core/common_widgets/common_cached_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../../core/common_widgets/common_icon.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';
import '../../../application/bloc/chat_group_bloc.dart';
import '../../../models/entities/group_member_entity.dart';

class MemberProfileItem extends StatelessWidget {

  final GroupMemberEntity? member;

  const MemberProfileItem({ super.key, required this.member });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            CommonCachedImage(
              imageUrl: member?.profileAvatar ?? "",
            ),
            Positioned(
              top: -5,
              right: -5,
              child: GestureDetector(
                onTap: (){
                  if(kDebugMode){
                    print("Should remove this member");
                  }
                  context.read<ChatGroupBloc>().add(RemoveMember(selectedId: member?.userId ?? ""));
                },
                child: Container(
                  padding: AppInsets.a4,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: CommonIcon(
                    iconData: BoxIcons.bx_x,
                    iconColor: AppColors.lSurfaceLow,
                    iconSize: AppSizes.size16 + 4,
                  )
                )
              )
            )
          ]
        )
      ],
    );
  }
}