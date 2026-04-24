import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_loading_indicator.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../application/login/bloc/login_bloc.dart';
import '../../../domain/enums/login_status.dart';

class FormSection extends HookWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    return Form(
      key: formKey,
      child: Column(
        spacing: AppSizes.size16,
        children: <Widget>[
          AppSizes.size24.height(),
          BlocSelector<LoginBloc, LoginState, String?>(
            selector: (state) => state.emailError,
            builder: (context, emailError) {
              return CommonTextField(
                hintText: "alex@example.com",
                text: "EMAIL",
                onChanged: (email) => context.read<LoginBloc>().add(OnEmailChanged(email: email)),
                controller: emailController,
                errorText: emailError ?? "",
                textInputType: TextInputType.emailAddress,
                prefixIconWidget: CommonIcon(iconData: IonIcons.person),
              );
            },
          ),
          // Will only rebuild if the password visibility changed or the error changed.
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.isPasswordVisible != current.isPasswordVisible || previous.passwordError != current.passwordError,
            builder: (context, state) {
              return CommonTextField(
                hintText: "********",
                onChanged: (password) => context.read<LoginBloc>().add(OnPasswordChanged(password: password)),
                text: "PASSWORD",
                controller: passwordController,
                isObsecure: !state.isPasswordVisible,
                iconSuffixData: state.isPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
                onSuffixButtonPressed: () => context.read<LoginBloc>().add(TogglePasswordVisibility()),
                textInputAction: TextInputAction.done,
                errorText: state.passwordError ?? "",
                prefixIconWidget: CommonIcon(iconData: IonIcons.lock_closed),
              );
            }
          ),
          // Only rebuild when loginStatus == loading state
          BlocSelector<LoginBloc, LoginState, bool>(
            selector: (state) => state.loginStatus == LoginStatus.loading,
            builder: (context, isLoading) {
              return CommonElevatedButton(
                elevatedPadding: EdgeInsets.zero,
                onButtonPressed: (){
                  if(!isLoading && (formKey.currentState?.validate() ?? true)){
                    context.read<LoginBloc>().add(
                      LoginSubmitted(
                        email: emailController.text,
                        password: passwordController.text,
                      )
                    );
                  }
                },
                child_: Container(
                  width: context.width,
                  height: AppSizes.size64,
                  padding: AppInsets.h4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBrandColor,
                    borderRadius: BorderRadius.circular(AppSizes.size16),
                  ),
                  child: isLoading ? CommonLoadingIndicator() : CommonText(
                    text: "Sign in",
                    fontColor: AppColors.lSurfaceLow,
                    fontSize: AppSizes.size16,
                    fontWeight: FontWeight.w500,
                  )
                )
              );
            }
          )
        ]
      )
    );
  }
}
