import 'package:chat/features/chat/chat_group/application/bloc/chat_group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_widgets/common_scaffold.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../components/sections/chat_group_header_section.dart';
import '../components/sections/list_contact_section.dart';
import '../components/sections/list_selected_member_section.dart';
import '../components/sections/search_section.dart';

class ChatGroupPage extends StatelessWidget {
  const ChatGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: Padding(
          padding: AppInsets.h24,
          child: BlocBuilder<ChatGroupBloc, ChatGroupState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ChatGroupHeaderSection(),
                  AppSizes.size24.height(),
                  SearchSection(),
                  ListSelectedMemberSection(),
                  AppSizes.size24.height(),
                  ListContactSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
