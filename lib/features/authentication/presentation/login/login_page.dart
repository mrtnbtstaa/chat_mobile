import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/common_widgets/common_show_dialog_builder.dart';
import '../../../../core/style/app_insets.dart';
import '../../application/login/bloc/login_bloc.dart';
import '../../domain/enums/login_status.dart';
import 'components/form_section.dart';
import 'components/login_header.dart';
import 'components/social_auth_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: AppInsets.h32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LoginHeader(),
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (previous, current) => previous.loginStatus != current.loginStatus, // logic gate will only listen if the loginStatus changed
                  listener: (context, state) {
                    if(state.loginStatus == LoginStatus.error) commonShowDialogBuilder(context, state.code ?? "");
                  },
                  child: FormSection()
                ),
                SocialAuthSection()
              ]
            )
          )
        )
      )
    );
  }
}
