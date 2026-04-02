import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common_widgets/common_text.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_insets.dart';
import '../../../../../../core/style/app_sizes.dart';
import '../../../application/bloc/chat_group_bloc.dart';
import '../contact_item.dart';

class ListContactSection extends StatelessWidget {
  const ListContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<ChatGroupBloc>().state;
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final contact = state.groupMembers[index];
          final String currentInitial = contact.fullName[0].toUpperCase();

          bool showPrefix = false;

          // Always show the prefix on the first item in the list
          if (index == 0) {
            showPrefix = true;
          } else {
            // Compare with the previous initial
            final String previousInitial = state.groupMembers[index - 1].fullName[0]
                .toUpperCase();
            if (currentInitial != previousInitial) {
              showPrefix = true;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSizes.spacing16,
            children: [
              if (showPrefix)
              CommonText(
                text: currentInitial,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font14,
                fontColor: AppColors.primaryBrandColor,
              ),
              ContactItem(
                username: contact.fullName,
                avatar: contact.profileAvatar,
                status: contact.status,
                onChanged: (value){
                  context.read<ChatGroupBloc>().add(SelectMember(isSelected: value, selectedId: contact.id));
                },
                isSelected: contact.isSelected,
              )
            ],
          );
        },
        separatorBuilder: (context, index) =>
            Padding(padding: AppInsets.a8),
        itemCount: state.groupMembers.length,
      ),
    );
  }
}
