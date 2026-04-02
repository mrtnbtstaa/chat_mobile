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

  final GroupMemberEntity member;

  const MemberProfileItem({ super.key, required this.member });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: AppSizes.size64,
              height: AppSizes.size64,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(member.profileAvatar),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: AppColors.lSurfaceLow,
                  width: AppSizes.size2,
                ),
                shape: BoxShape.circle,
              )
            ),
            Positioned(
              top: -5,
              right: -5,
              child: GestureDetector(
                onTap: (){
                  if(kDebugMode){
                    print("Should remove this member");
                  }
                  context.read<ChatGroupBloc>().add(RemoveMember(selectedId: member.id));
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