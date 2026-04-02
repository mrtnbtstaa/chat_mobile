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
import '../controllers/login_controller.dart';

class FormSection extends StatelessWidget {

  const FormSection({super.key});

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
          AppSizes.size24.height(),
          CommonTextField(
            hintText: "alex@example.com",
            text: "EMAIL",
            onChanged: (email) => loginBloc.add(OnEmailChanged(email: email)),
            controller: controllers.emailController,
            errorText: loginBloc.state.emailError ?? "",
            textInputType: TextInputType.emailAddress,
            prefixIconWidget: CommonIcon(iconData: IonIcons.person)
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (password) => loginBloc.add(OnPasswordChanged(password: password)),
            text: "PASSWORD",
            controller: controllers.passwordController,
            isObsecure: !loginBloc.state.isPasswordVisible,
            hasSuffixIcon: true,
            iconSuffixData: loginBloc.state.isPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            onSuffixButtonPressed: () => loginBloc.add(TogglePasswordVisibility()),
            textInputAction: TextInputAction.done,
            errorText: loginBloc.state.passwordError ?? "",
            prefixIconWidget: CommonIcon(iconData: IonIcons.lock_closed),
          ),
          CommonElevatedButton(
            elevatedPadding: EdgeInsets.zero,
            onButtonPressed: () => isLoading ? null : {              // commonShowDialog(context),
              if(controllers.formKey.currentState?.validate() ?? true){
                loginBloc.add(
                  LoginSubmitted(
                    email: controllers.emailController.text,
                    password: controllers.passwordController.text
                  )
                )
              }
            },
            child_: Container(
              width: context.width,
              height: AppSizes.size64,
              padding: AppInsets.h4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryBrandColor,
                borderRadius: BorderRadius.circular(AppSizes.size16)
              ),
              child: isLoading ? CommonLoadingIndicator() : CommonText(
                text: "Sign in",
                fontColor: AppColors.lSurfaceLow,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.w500,
              ),
            )
          )
        ]
      ),
    );
  }
}