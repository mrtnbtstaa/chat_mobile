import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/application/login/bloc/login_bloc.dart';
import '../../features/authentication/application/register/bloc/register_bloc.dart';
import '../../features/authentication/domain/entities/auth_entity.dart';
import '../../features/authentication/domain/params/login_param.dart';
import '../../features/authentication/infrastructure/services/media_service.dart';
import '../../features/authentication/presentation/login/controllers/login_controller.dart';
import '../../features/authentication/presentation/login/login_page.dart';
import '../../features/authentication/presentation/register/controllers/register_controller.dart';
import '../../features/authentication/presentation/register/register_page.dart';
import '../../features/chat/chat/presentation/chat_content.dart';
import '../../features/chat/chat_message/presentation/chat_message_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/profile/presentation/profile_content.dart';
import '../../features/settings/presentation/settings_content.dart';
import '../common_widgets/common_text.dart';
import '../di/di.dart';
import '../usecases/base_usecase.dart';
import 'app_routes.dart';


class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.login: return _buildPageRoute(
        MultiBlocProvider(
          providers: [
            RepositoryProvider(
              create: (context) => LoginController(),
              dispose: (controller) => controller.dispose(),
            )
          ],
          child: BlocProvider(
            create: (context) => LoginBloc(loginUseCase: sl<BaseUsecase<AuthEntity, LoginParam>>()),
            child: LoginPage(),
          )
        ),
        settings
      );
      case AppRoutes.register: return _buildPageRoute(
        MultiBlocProvider(
          providers: [
            RepositoryProvider(create: (context) => MediaService()),
            RepositoryProvider<RegisterController>(
              create: (context) => RegisterController(),
              dispose: (controller) => controller.dispose(),
            )
          ],
          child: BlocProvider(
            create: (context) => RegisterBloc(
              mediaService: context.read<MediaService>()
            ),
            child: RegisterPage(),
          ),
        ),
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