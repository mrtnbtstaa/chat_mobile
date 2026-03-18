
import 'register_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../application/register/bloc/register_bloc.dart';
import '../controllers/register_controller.dart';

class FieldContent extends StatelessWidget {

  const FieldContent({ 
    super.key,
    required this.imageProvider
  });

  final ImageProvider imageProvider;

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
          GestureDetector(
            onTap: () => registerBloc.add(RegisterCameraOpened()),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.bgColor02,
                      width: 3.0
                    )
                  ),
                  child: CircleAvatar(
                    radius: AppSizes.size64,
                    backgroundImage: imageProvider
                  )
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CommonIcon(
                    iconData: Icons.camera_alt,
                    iconSize: AppSizes.size32
                  )
                )
              ]
            )
          ),
          CommonTextField(
            hintText: "Johndoe",
            text: "Username",
            onChanged: (username) => registerBloc.add(OnUsernameChanged(username: username)),
            controller: controllers.username,
            errorText: registerBloc.state.usernameError ?? ""
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (password) => registerBloc.add(OnPasswordChanged(password: password)),
            text: "Password",
            controller: controllers.password,
            isObsecure: !registerBloc.state.isPasswordVisible,
            hasSuffixIcon: true,
            onSuffixButtonPressed: () => registerBloc.add(TogglePasswordVisibility()),
            iconSuffixData: registerBloc.state.isPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            errorText: registerBloc.state.passwordError ?? ""
          ),
          CommonTextField(
            hintText: "********",
            onChanged: (confirmPassword) => registerBloc.add(OnConfirmPasswordChanged(confirmPassword: confirmPassword)),              
            text: "Confirm Password",                     
            onSuffixButtonPressed: () => registerBloc.add(ToggleConfirmPasswordVisibility()), 
            controller: controllers.confirmPassword,
            isObsecure: !registerBloc.state.isConfirmPasswordVisible,
            hasSuffixIcon: true,
            iconSuffixData: registerBloc.state.isConfirmPasswordVisible ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
            textInputAction: TextInputAction.done,
            errorText: registerBloc.state.confirmPasswordError ?? ""
          ),
          RegisterButtonContent()
        ]
      )
    );
  }
}                                   