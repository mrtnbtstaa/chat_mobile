import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/extensions/double_extension.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/widgets.dart';

class PasswordResetHeaderSection extends StatelessWidget {
const PasswordResetHeaderSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonText(
            text: "Secure your account",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font32,
          ),
          CommonText(text: "Ensure your new password is unique and follows our security to maintain privacy."),
          AppSizes.size24.height()
        ]
      )
    );
  }
}