import 'package:chat/core/common_widgets/common_scaffold.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_insets.dart';
import 'components/login_now_content.dart';
import 'components/register_header.dart';
import '../../../../core/router/app_routes.dart';
import '../../application/register/bloc/register_bloc.dart';
import '../../domain/enums/register_status.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/form_section.dart';
import '../../../../core/style/app_sizes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: AppColors.lBaseBackground,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: AppInsets.h32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.size8,
              children: <Widget>[
                RegisterHeader(),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if(state.registerStatus == RegisterStatus.success){
                      context.go(AppRoutes.home);
                    }else if(state.registerStatus == RegisterStatus.error){
                      // ScaffoldMessenger.of(context)
                      // ..removeCurrentSnackBar()
                      // ..showSnackBar(SnackBar(
                      //   content: CommonText(text: state.errorMessage)
                      // ));
                    }
                  },
                  builder: (context, state) {
                    // ImageProvider imageProvider = const AssetImage(AppImages.profile);
                    // if(state.imagePath.isNotEmpty) imageProvider = FileImage(File(state.imagePath));
                    return FormSection(
                      // imageProvider: imageProvider,
                    );
                  },
                ),
                LoginNowContent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
