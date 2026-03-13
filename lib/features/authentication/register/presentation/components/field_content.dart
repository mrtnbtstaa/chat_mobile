import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_insets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../application/bloc/register_bloc.dart';
import '../controllers/register_controller.dart';

class FieldContent extends StatelessWidget {

  const FieldContent({ 
    super.key,
    required this.passwordObsecure,
    required this.confirmPasswordObsecure,
    required this.imageProvider
  });

  final bool passwordObsecure;
  final bool confirmPasswordObsecure;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context){
    final controllers = context.read<RegisterController>();
    final registerBloc = context.read<RegisterBloc>();
    return Column(
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
                  backgroundImage: imageProvider,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CommonIcon(
                  iconData: Icons.camera_alt,
                  iconSize: AppSizes.size32
                ),
              ),
            ],
          ),
        ),
        CommonTextField(
          hintText: "Johndoe",
          text: "Username",
          onChanged: (val){},
          controller: controllers.username
        ),
        CommonTextField(
          hintText: "********",
          onChanged: (val){},
          text: "Password",
          controller: controllers.password,
          isObsecure: !passwordObsecure,
          hasSuffixIcon: true,
          onSuffixButtonPressed: () => registerBloc.add(TogglePasswordVisibility()),
          iconSuffixData: passwordObsecure ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
        ),
        CommonTextField(
          hintText: "********",
          onChanged: (val){},
          text: "Confirm Password",
          onSuffixButtonPressed: () => registerBloc.add(ToggleConfirmPasswordVisibility()),
          controller: controllers.confirmPassword,
          isObsecure: !confirmPasswordObsecure,
          hasSuffixIcon: true,
          iconSuffixData: confirmPasswordObsecure ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
          textInputAction: TextInputAction.done,
        ),
        CommonElevatedButton(
          width: context.width,
          height: AppSizes.size64,
          elevatedPadding: AppInsets.h4,
          onButtonPressed: () => registerBloc.add(RegisterSubmitted(
            username: controllers.username.text,
            password: controllers.password.text,
            confirmPassword: controllers.confirmPassword.text
          )),
          text: "Sign up",
        )
      ]
    );
  }
}                                   