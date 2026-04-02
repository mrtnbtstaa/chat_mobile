import 'package:chat/core/extensions/double_extension.dart';
import 'package:chat/features/chat/chat_group/application/bloc/chat_group_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../member/member_profile_item.dart';
import 'package:flutter/material.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';

class ListSelectedMemberSection extends StatelessWidget {
  const ListSelectedMemberSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<ChatGroupBloc>().state;
    return Column(
      spacing: AppSizes.spacing4,
      children: <Widget>[
        AppSizes.size32.height(),
        SizedBox(
          height: AppSizes.size64,
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemBuilder: (context, index) => MemberProfileItem(member: state.addedGroupMembers[index]),
            separatorBuilder: (context, index) =>
                Padding(padding: AppInsets.h8),
            itemCount: state.addedGroupMembers.length,
          ),
        ),
      ],
    );
  }
}
