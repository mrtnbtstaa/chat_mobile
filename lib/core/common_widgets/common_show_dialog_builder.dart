import 'package:chat/core/constants/error_icons.dart';
import 'package:chat/core/constants/errors.dart';

import 'common_show_dialog.dart';
import '../extensions/context_extension.dart';
import '../style/app_colors.dart';
import '../style/app_insets.dart';
import 'package:flutter/material.dart';



Future<void> commonShowDialogBuilder(BuildContext context, String code) async {

  final findErrorMap = errorMap.entries.firstWhere((error) => error.key == code);
  final findErrorIconMap = errorIcons.entries.firstWhere((errIcon) => errIcon.key == code);

  return showDialog(
    context: context,
    builder:(context) {
      return CommonShowDialog(
        edgeInsetPadding: AppInsets.a16,
        title: findErrorMap.value["title"] ?? "",
        description: findErrorMap.value["description"] ?? "",
        iconData: findErrorIconMap.value,
        height: context.height / 2,
        iconColor: AppColors.errorRed,
      );
    },
  );
}