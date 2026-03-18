import 'package:chat/core/style/app_insets.dart';
import 'package:flutter/material.dart';
import 'chat_item.dart';

class ListviewChatSection extends StatelessWidget {

  const ListviewChatSection({ 
    super.key,
  });


  @override
  Widget build(BuildContext context){
    return Expanded(
      child: ListView.builder(
        padding: AppInsets.v4,
        primary: true,
        itemCount: 5,
        itemBuilder:(context, index) {
          return ChatItem();
        },
      )
    );
  }
}