
import 'package:chat/features/authentication/domain/enums/register_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_loading_indicator.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../application/register/bloc/register_bloc.dart';
import '../controllers/register_controller.dart';
import 'package:flutter/material.dart';

class RegisterButtonContent extends StatelessWidget {

  const RegisterButtonContent({ 
    super.key,
   });

  @override
  Widget build(BuildContext context){
    final controllers = context.read<RegisterController>();
    final state = context.read<RegisterBloc>().state;
    final bool isLoading = state.registerStatus == RegisterStatus.loading;
    return CommonElevatedButton(
      width: context.width,
      height: AppSizes.size64,
      elevatedPadding: AppInsets.h4,
      onButtonPressed: () => isLoading ? null : {
        if(controllers.formKey.currentState?.validate() ?? true){
          context.read<RegisterBloc>().add(RegisterSubmitted(
            username: controllers.username.text,
            password: controllers.password.text,
            confirmPassword: controllers.confirmPassword.text
          ))
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
    );
  }
}