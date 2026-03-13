// import 'package:flutter/material.dart';
// import 'package:hoav2/core/common_widgets/common_text.dart';
// import 'package:hoav2/core/constant/app_colors.dart';
// import 'package:hoav2/core/constant/app_sizes.dart';

// class CommonCheckbox extends StatelessWidget {

//   const CommonCheckbox({ 
//     super.key,
//     required this.text,
//     required this.onChanged,
//     required this.value
//    });


//   final String text;
//   final bool value;
//   final void Function(bool?)? onChanged;

//   @override
//   Widget build(BuildContext context){
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Checkbox(
//           value: value,
//           onChanged: onChanged,
//           side: BorderSide(
//             color: AppColors.secondaryTextColor,
//           ),
//           checkColor: AppColors.secondaryColor,
//           activeColor: AppColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusGeometry.all(Radius.circular(AppSizes.size4))
//           ),
//           splashRadius: AppSizes.size8,
//           materialTapTargetSize: MaterialTapTargetSize.padded,
//           fillColor: WidgetStateColor.resolveWith((color) => value ? AppColors.accentColor : AppColors.secondaryColor),
//         ),
//         CommonText(text: text)
//       ],
//     );
//   }
// }