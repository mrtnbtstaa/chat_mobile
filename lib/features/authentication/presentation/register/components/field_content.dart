
import 'package:chat/core/common_widgets/common_icon.dart';

import 'register_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../application/register/bloc/register_bloc.dart';
import '../controllers/register_controller.dart';

class FieldContent extends StatelessWidget {

  const FieldContent({ 
    super.key,
    // required this.imageProvider
  });

  // final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context){
    final controllers = context.read<RegisterController>();
    final registerBloc = context.read<RegisterBloc>();
    return Form(
      key: controllers.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: AppSizes.size16,
        children: <Widget>[
          CommonTextField(
            hintText: "John Doe",
            text: "FULL NAME",
            onChanged: (username) => registerBloc.add(OnFullNameChanged(fullName: username)),
            controller: controllers.fullName,
            errorText: registerBloc.state.fullNameError ?? "",
            prefixIconWidget: CommonIcon(iconData: IonIcons.person)
          ),
          CommonTextField(
            hintText: "alex@example.com",
            text: "EMAIL",
            onChanged: (email) => registerBloc.add(OnEmailChanged(email: email)),
            controller: controllers.email,
            errorText: registerBloc.state.emailError ?? "",
            textInputType: TextInputType.emailAddress,
            prefixIconWidget: CommonIcon(iconData: IonIcons.mail)
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (password) => registerBloc.add(OnPasswordChanged(password: password)),
            text: "PASSWORD",
            controller: controllers.password,
            isObsecure: !registerBloc.state.isPasswordVisible,
            hasSuffixIcon: true,
            onSuffixButtonPressed: () => registerBloc.add(TogglePasswordVisibility()),
            iconSuffixData: registerBloc.state.isPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            errorText: registerBloc.state.passwordError ?? "",
            prefixIconWidget: CommonIcon(iconData: IonIcons.lock_closed)
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (confirmPassword) => registerBloc.add(OnConfirmPasswordChanged(confirmPassword: confirmPassword)),              
            text: "CONFIRM PASSWORD",                     
            onSuffixButtonPressed: () => registerBloc.add(ToggleConfirmPasswordVisibility()), 
            controller: controllers.confirmPassword,
            isObsecure: !registerBloc.state.isConfirmPasswordVisible,
            hasSuffixIcon: true,
            iconSuffixData: registerBloc.state.isConfirmPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            textInputAction: TextInputAction.done,
            errorText: registerBloc.state.confirmPasswordError ?? "",
            prefixIconWidget: CommonIcon(iconData: IonIcons.lock_closed)
          ),
          RegisterButtonContent()
        ]
      )
    );
  }
}                                   