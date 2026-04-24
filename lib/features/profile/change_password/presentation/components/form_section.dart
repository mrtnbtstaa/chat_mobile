import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_loading_indicator.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../../application/bloc/change_password_bloc.dart';
import '../../domain/enums/change_password_status.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';

class FormSection extends HookWidget {
const FormSection({ super.key });

  @override
  Widget build(BuildContext context){
    final bloc = context.read<ChangePasswordBloc>();
    final state = bloc.state;
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final isLoading = state.status == ChangePasswordStatus.loading;
    return Padding(
      padding: AppInsets.h24,
      child: Form(
        key: formKey,
        child: Column(
          spacing: AppSizes.spacing8,
          children: <Widget>[
            CommonTextField(
              text: "CURRENT PASSWORD",
              hintText: "********",
              onChanged: (currentPassword) => bloc.add(OnCurrentPasswordChanged(currentPassword)),
              controller: currentPasswordController,
              prefixIconData: IonIcons.lock_closed,
              onSuffixButtonPressed: (){},
              errorText: state.currentPasswordError,
              iconSuffixData: Iconsax.eye_bold
            ),
            CommonTextField(
              text: "NEW PASSWORD",
              hintText: "********",
              onChanged: (newPassword) => bloc.add(OnNewPasswordChanged(newPassword)),
              controller: newPasswordController,
              prefixIconData: IonIcons.lock_closed,
              onSuffixButtonPressed: (){},
              errorText: state.newPasswordError,
              iconSuffixData: Iconsax.eye_bold
            ),
            CommonTextField(
              text: "CONFIRM PASSWORD",
              hintText: "********",
              onChanged: (confirmPassword) => bloc.add(OnConfirmPasswordChanged(confirmPassword)),
              controller: confirmPasswordController,
              prefixIconData: IonIcons.lock_closed,
              onSuffixButtonPressed: (){},
              errorText: state.confirmPasswordError,
              iconSuffixData: Iconsax.eye_bold
            ),
            CommonElevatedButton(
              elevatedPadding: EdgeInsets.zero,
              onButtonPressed: () => isLoading ? null : {
                if(formKey.currentState?.validate() ?? true){
                  bloc.add(
                    PasswordSubmitted(
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                      confirmPassword: confirmPasswordController.text
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
                  text: "Update Password",
                  fontColor: AppColors.lSurfaceLow,
                  fontSize: AppSizes.size16,
                  fontWeight: FontWeight.w500,
                ),
              )
            )
          ]
        ),
      )
    );
  }
}