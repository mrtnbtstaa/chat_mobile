import '../common_widgets/common_text.dart';
import 'app_routes.dart';
import '../../features/authentication/login/presentation/login_page.dart';
import '../../features/authentication/register/presentation/register_page.dart';
import '../../features/chat/chat/presentation/chat_content.dart';
import '../../features/chat/chat_message/presentation/chat_message_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/profile/presentation/profile_content.dart';
import '../../features/settings/presentation/settings_content.dart';
import 'package:flutter/material.dart';


class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.login: return _buildPageRoute(
        LoginPage(),
        settings
      );
      case AppRoutes.register: return _buildPageRoute(
        RegisterPage(),
        settings
      );
      case AppRoutes.chat: return _buildPageRoute(
        ChatContent(),
        settings
      );
      case AppRoutes.chatMessage: return _buildPageRoute(
        ChatMessagePage(),
        settings
      );
      case AppRoutes.profile: return _buildPageRoute(
        ProfileContent(),
        settings
      );
      case AppRoutes.settings: return _buildPageRoute(
        SettingsContent(),
        settings
      );
      case AppRoutes.home: return _buildPageRoute(
        HomePage(),
        settings
      );
      default: return _buildPageRoute(_undefineWidget(), settings);
    }
  }

  static PageRouteBuilder<dynamic> _buildPageRoute(Widget page, RouteSettings settings){
    return PageRouteBuilder(
      settings: settings,
      pageBuilder:(context, animation, secondaryAnimation) => page, 
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero
    );
  }

  static Widget _undefineWidget(){
    return Scaffold(
      body: Center(
        child: CommonText(text: "No route found"),
      ),
    );
  }
}