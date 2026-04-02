import 'package:flutter/material.dart';

import '../setting_list_tile.dart';
import '../settings_switcher.dart';

class SettingsSection extends StatelessWidget {
const SettingsSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        SettingListTile(
          iconData: Icons.lock,
          text: "Change Password",
          onTap: (){}
        ),
        SettingsSwitcher(
          iconData: Icons.notifications,
          text: "Notifications",
          onTap: (){},
        ),
      ],
    );
  }
}