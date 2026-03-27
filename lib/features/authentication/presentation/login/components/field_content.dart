import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_loading_indicator.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../application/login/bloc/login_bloc.dart';
import '../../../domain/enums/login_status.dart';
import '../controllers/login_controller.dart';

class FieldContent extends StatelessWidget {

  const FieldContent({super.key});


  @override
  Widget build(BuildContext context){
    final controllers = context.read<LoginController>();
    final loginBloc = context.watch<LoginBloc>();
    final state = loginBloc.state;
    final bool isLoading = state.loginStatus == LoginStatus.loading;
    return Form(
      key: controllers.formKey,
      child: Column(
        spacing: AppSizes.size16,
        children: <Widget>[
          CommonTextField(
            hintText: "Johndoe",
            text: "Username",
            onChanged: (username) => loginBloc.add(OnUsernameChanged(username: username)),
            controller: controllers.usernameController,
            errorText: loginBloc.state.usernameError ?? "",
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (password) => loginBloc.add(OnPasswordChanged(password: password)),
            text: "Password",
            controller: controllers.passwordController,
            isObsecure: !loginBloc.state.isPasswordVisible,
            hasSuffixIcon: true,
            iconSuffixData: loginBloc.state.isPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            onSuffixButtonPressed: () => loginBloc.add(TogglePasswordVisibility()),
            textInputAction: TextInputAction.done,
            errorText: loginBloc.state.passwordError ?? "",
          ),
          CommonElevatedButton(
            width: context.width,
            height: AppSizes.size64,
            elevatedPadding: AppInsets.h4,
            onButtonPressed: () => isLoading ? null : {              // commonShowDialog(context),
              if(controllers.formKey.currentState?.validate() ?? true){
                loginBloc.add(
                  LoginSubmitted(
                    username: controllers.usernameController.text,
                    password: controllers.passwordController.text
                  )
                )
              }
            },
            child_: GlassContainer(
              width: context.width,
              height: AppSizes.size64,
              child: isLoading ? CommonLoadingIndicator() : CommonText(
              text: "Sign up",
              fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]
      ),
    );
  }
}