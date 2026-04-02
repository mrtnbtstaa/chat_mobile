import 'package:chat/features/home/models/entities/bottom_navbar_item.dart';

class BottomTabbarConstants {
  static const List<BottomNavbarItem> items = [
    BottomNavbarItem(iconKey: "chat", name: "Chat", index: 0),
    BottomNavbarItem(iconKey: "profile", name: "Profile", index: 1),
    BottomNavbarItem(iconKey: "settings", name: "Settings", index: 2),
  ];
}