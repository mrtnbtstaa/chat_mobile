import 'package:chat/core/common_widgets/common_show_dialog_builder.dart';
import 'package:chat/features/profile/change_password/application/bloc/change_password_bloc.dart';
import 'package:chat/features/profile/change_password/domain/enums/change_password_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/common_scaffold.dart';
import 'components/appbar_change_password_section.dart';
import 'components/form_section.dart';
import 'components/password_reset_header_section.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppbarChangePasswordSection(),
              PasswordResetHeaderSection(),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener:(context, state) {
                  if(state.status == ChangePasswordStatus.success) context.pop();
                  if(state.status == ChangePasswordStatus.error) commonShowDialogBuilder(context, state.code);
                },
                builder:(context, state) => FormSection(),
              )
            ]
          )
        )
      )
    );
  }
}
