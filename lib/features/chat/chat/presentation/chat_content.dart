import 'package:flutter/material.dart';

import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/style/app_sizes.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/common_widgets/common_container_background.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import 'components/chat_header_section.dart';
import 'components/listview_chat_section.dart';

class ChatContent extends StatefulWidget {

  const ChatContent({ super.key });

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {

  late ScrollController _scrollController;
  
  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  void _onScroll(){
    if(_isBottom){} // Call bloc to load more chat
  }

  bool get _isBottom{
    if(!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Only trigger when 90% through the list
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CommonContainerBackground(),
            GlassContainer(
              borderRadiusGeometry: BorderRadius.circular(0.0),
              sigmaX: AppSizes.size2,
              sigmaY: AppSizes.size2,
              height: context.height,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    ChatHeaderSection(
                      onSearchTap: (){},
                      onGroupTap: (){},
                    ),
                    PrimaryScrollController(
                      controller: _scrollController,
                      child: ListviewChatSection()
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}
