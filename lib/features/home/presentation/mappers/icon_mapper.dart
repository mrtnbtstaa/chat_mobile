import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class IconMapper {
  static IconData getIcon(String key){
    switch(key){
      case 'chat': return BoxIcons.bx_chat;
      case 'profile': return BoxIcons.bx_user;
      case 'settings': return Icons.settings;
      default: return Icons.abc;
    }
  }
}