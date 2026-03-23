import 'package:chat/core/common_widgets/common_show_dialog_builder.dart';
import 'package:chat/features/authentication/domain/enums/login_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/login/bloc/login_bloc.dart';
import 'components/form_section.dart';
import '../../../../core/common_widgets/animated_background.dart';
import '../../../../core/common_widgets/common_container.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/style/app_sizes.dart';
import '../../../../core/extensions/context_extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CommonContainer(
            width: context.width,
            height: context.height,
            child: SizedBox.expand(),
          ),
          Positioned.fill(child: AnimatedBackground()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSizes.size8,
            children: <Widget>[
              CommonText(
                text: "Welcome Back!",
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.font32,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (previous, current) => previous.loginStatus != current.loginStatus,
                listener: (context, state) {
                  if(state.loginStatus == LoginStatus.error){
                    commonShowDialogBuilder(context, state.code ?? "");
                  }
                },
                builder: (context, state){
                  if(kDebugMode){
                    print("\x1B[32mCurrent state: ${state.loginStatus} and ${state.code}");
                  }
                  return FormSection();
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
