import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class UserProfileStatus extends StatelessWidget {

  const UserProfileStatus({ 
    super.key,
    this.color,
    this.descriptionColor,
    this.title,
    this.description,
    this.fontWeight
   });

  final Color? color;
  final Color? descriptionColor;
  final String? title;
  final String? description;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h16,
      child: Row(
        spacing: AppSizes.size4,
        children: <Widget>[
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${title ?? "Status:"} ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizes.font16
                    )
                  ),
                  TextSpan(
                    text: description ?? "Online",
                    style: TextStyle(
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: AppSizes.font16,
                      color: descriptionColor ?? AppColors.accentColor
                    )
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}