import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/common_widgets/common_elevated_button.dart';
import '../../../core/common_widgets/common_icon.dart';
import '../../../core/common_widgets/common_loading_indicator.dart';
import '../../../core/common_widgets/common_text.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/double_extension.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_insets.dart';
import '../../../core/style/app_sizes.dart';
import '../../authentication/application/auth/bloc/auth_bloc.dart';
import 'components/sections/application_setting_section.dart';


class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApplicationSettingSection(),
        AppSizes.size24.height(),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return Padding(
              padding: AppInsets.h8,
              child: CommonElevatedButton(
                withIcon: true,
                overlayColor: Colors.transparent,
                elevatedPadding: AppInsets.h8,
                backgroundColor: AppColors.error,
                iconData: IonIcons.log_out,
                iconColor: AppColors.lSurfaceLow,
                padding: AppInsets.h32,
                width: context.width,
                height: AppSizes.size64,
                onButtonPressed: () => context.read<AuthBloc>()..add(LogoutRequested()),
                child_: Container(
                  width: context.width,
                  height: AppSizes.size64,
                  padding: AppInsets.h4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(AppSizes.size16),
                  ),
                  child: isLoading
                    ? CommonLoadingIndicator()
                    : Row(
                    spacing: AppSizes.spacing8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonIcon(
                        iconData: IonIcons.log_out,
                        iconSize: AppSizes.size32,
                        iconColor: AppColors.lSurfaceLow,
                      ),
                      CommonText(
                        text: "Logout",
                        fontColor: AppColors.lSurfaceLow,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
