import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/widgets.dart';

class LoginHeader extends StatelessWidget {
const LoginHeader({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppSizes.size32.height(),
        CommonText(
          text: "Nexus",
          fontWeight: FontWeight.w700,
          fontSize: AppSizes.font32,
        ),
        AppSizes.size24.height(),
        CommonText(
          text: "Welcome Back",
          fontWeight: FontWeight.w700,
          fontSize: AppSizes.font32,
        ),
        CommonText(
          text: "Please enter your details to start chatting with your friends.",
          fontSize: AppSizes.font16,
        ),
      ],
    );
  }
}