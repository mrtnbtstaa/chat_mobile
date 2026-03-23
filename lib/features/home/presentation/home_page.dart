import 'package:chat/core/utils/flutter_secure_storage_manager.dart';
import 'package:chat/core/utils/shared_preferences_manager.dart';
import 'package:chat/features/chat/chat/presentation/chat_content.dart';
import 'package:chat/features/home/presentation/components/bottom_tabbar_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/common_widgets/common_scaffold.dart';
import '../../profile/presentation/profile_content.dart';
import '../../settings/presentation/settings_content.dart';
import 'components/bottom_tabbar.dart';

class HomePage extends StatefulWidget {
const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: BottomTabbarConstants.items.length, vsync: this);
    _controller.addListener(_controllerIndexListener);
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void _controllerIndexListener() => setState(() => _currentIndex = _controller.index);

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              TabBarView(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ChatContent(),
                  ProfileContent(),
                  SettingsContent()
                ],
              ),
              BottomTabbar(
                controller: _controller,
                currentIndex: _currentIndex
              )
            ]
          );
        }
      )
    );
  }
}