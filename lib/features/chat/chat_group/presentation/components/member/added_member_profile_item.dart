import 'package:flutter/material.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_sizes.dart';
import '../../../models/entities/group_member_entity.dart';

class AddedMemberProfileItem extends StatelessWidget {

  final GroupMemberEntity member;

  const AddedMemberProfileItem({ super.key, required this.member});

  @override
  Widget build(BuildContext context){
    return Container(
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
    );
  }
}