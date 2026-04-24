import 'package:chat/core/common_widgets/common_cached_image.dart';
import 'package:flutter/material.dart';
import '../../../models/entities/group_member_entity.dart';

class AddedMemberProfileItem extends StatelessWidget {

  final GroupMemberEntity member;

  const AddedMemberProfileItem({ super.key, required this.member});

  @override
  Widget build(BuildContext context){
    return CommonCachedImage(
      imageUrl: member.profileAvatar ?? "",
    );
  }
}