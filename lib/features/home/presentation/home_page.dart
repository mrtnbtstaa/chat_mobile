import '../../../core/common_widgets/common_material.dart';
import '../../../core/common_widgets/common_sliver_app_bar.dart';
import '../../../core/extensions/double_extension.dart';
import '../../../core/style/app_sizes.dart';
import '../../chat/chat/presentation/chat_content.dart';
import 'components/bottom_tabbar_constants.dart';
import 'package:flutter/material.dart';
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
    return CommonMaterial(
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: AppSizes.size16.height()),
          CommonSliverAppBar(text: "Home"),
          SliverFillRemaining(
            child: Builder(
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
                        SettingsContent(),
                      ],
                    ),
                    BottomTabbar(
                      controller: _controller,
                      currentIndex: _currentIndex
                    )
                  ]
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}