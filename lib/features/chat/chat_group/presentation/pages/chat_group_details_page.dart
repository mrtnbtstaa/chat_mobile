import 'package:chat/features/chat/chat_group/models/entities/group_member_entity.dart';
import 'package:flutter/foundation.dart';

import '../components/sections/list_member_section.dart';
import 'package:flutter/material.dart';
import '../../../chat_message/presentation/components/group_avatar_section.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/common_widgets/common_scaffold.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../components/chat_group_details_header_section.dart';

class ChatGroupDetailsPage extends StatelessWidget {

  final List<GroupMemberEntity> members;

  const ChatGroupDetailsPage({ super.key, required this.members });

  @override
  Widget build(BuildContext context){
    if(kDebugMode){
      print("Members: ${members.length}");
    }
    return CommonScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: AppInsets.h24,
            child: Column(
              children: <Widget>[
                ChatGroupDetailsHeaderSection(),
                AppSizes.size24.height(),
                GroupAvatarSection(onTap: (){}),
                AppSizes.size24.height(),
                CommonTextField(
                  text: "GROUP NAME",
                  fontSize: AppSizes.font12,
                  fontColor: AppColors.ltextSecondary,
                  hintText: "Ex: Digital Ocean",
                  onChanged: (val) {},
                  controller: TextEditingController()
                ),
                ListMemberSection(members: members)
              ]
            )
          )
        )
      )
    );
  }
}