import 'dart:io';

import 'package:chat/core/router/app_routes.dart';
import 'package:chat/features/authentication/application/register/bloc/register_bloc.dart';
import 'package:chat/features/authentication/domain/enums/register_status.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/form_section.dart';
import '../../../../core/common_widgets/animated_background.dart';
import '../../../../core/common_widgets/common_container.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/style/app_sizes.dart';
import '../../../../core/extensions/context_extension.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            CommonContainer(
              width: context.width,
              height: context.height,
              child: SizedBox.expand(),
            ),
            Positioned.fill(child: AnimatedBackground()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.size8,
              children: <Widget>[
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
                    ImageProvider imageProvider = const AssetImage(AppImages.profile);
                    if(state.imagePath.isNotEmpty) imageProvider = FileImage(File(state.imagePath));
                    return FormSection(
                      imageProvider: imageProvider,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
