import 'package:flutter/material.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/style/app_sizes.dart';
import 'components/personal_information_section.dart';
import 'components/profile_section.dart';
import 'components/security_section.dart';
// import 'components/status_mode_section.dart';

class ProfileContent extends StatelessWidget {
const ProfileContent({ super.key });

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          AppSizes.size32.height(),
          ProfileSection(),
          PersonalInformationSection(),
          SecuritySection(),
          // StatusModeSection(),
          AppSizes.size32.height()
        ]
      )
    );
  }
}