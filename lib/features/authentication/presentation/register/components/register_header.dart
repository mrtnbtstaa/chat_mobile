import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
const RegisterHeader({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        AppSizes.size32.height(),
        CommonText(
        text: "Create your account",
        fontWeight: FontWeight.w700,
        fontSize: AppSizes.font32,
      ),
      CommonText(
        text: "Enter your details to start your journey.",
        fontSize: AppSizes.font16,
      ),
      ],
    );
  }
}