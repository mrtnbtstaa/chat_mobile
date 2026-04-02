import 'package:chat/features/chat/chat_group/models/entities/group_member_entity.dart';
import 'package:flutter/material.dart';
import '../member/member_header_content.dart';
import '../member/added_member_profile_item.dart';
import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';


class ListMemberSection extends StatelessWidget {

  final List<GroupMemberEntity> members;

  const ListMemberSection({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.spacing4,
      children: <Widget>[
        MemberHeaderContent(memberCount: members.length),
        AppSizes.size16.height(),
        SizedBox(
          height: AppSizes.size64,
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemBuilder: (context, index) => AddedMemberProfileItem(member: members[index]),
            separatorBuilder: (context, index) => Padding(padding: AppInsets.h8),
            itemCount: members.length
          ),
        )
      ],
    );
  }
}
