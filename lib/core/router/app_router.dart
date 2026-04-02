import '../../features/chat/chat_group/application/bloc/chat_group_bloc.dart';
import '../../features/chat/chat_group/models/entities/group_member_entity.dart';
import '../../features/chat/chat_group/presentation/pages/chat_group_page.dart';
import '../../features/chat/chat_group/presentation/pages/chat_group_details_page.dart';

import '../../features/settings/presentation/pages/appearance_page.dart';

import '../contracts/i_user_storage.dart';
import '../../features/authentication/application/register/bloc/register_bloc.dart';
import '../../features/authentication/presentation/register/controllers/register_controller.dart';
import '../../features/authentication/presentation/register/register_page.dart';
import '../../features/chat/chat/infrastructure/datasources/inbox_ws_client.dart';
import '../../features/chat/chat_message/domain/entities/paginated_messages.dart';
import '../../features/chat/chat_message/infrastructure/services/chat_socket_service.dart';

import '../../features/chat/chat/domain/entities/sub_entities/chat_result_entity.dart';
import '../../features/chat/chat_message/infrastructure/datasources/web_sockent_client.dart';
import '../../features/chat/chat_message/application/bloc/chat_bloc.dart';
import '../../features/chat/chat_message/domain/entities/chat_message_entity.dart';
import '../../features/chat/chat_message/domain/params/chat_message_param.dart';
import '../../features/chat/chat_message/presentation/chat_message_page.dart';
import '../../features/chat/chat_message/presentation/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/application/login/bloc/login_bloc.dart';
import '../../features/authentication/domain/entities/auth_entity.dart';
import '../../features/authentication/domain/params/login_param.dart';
import '../../features/authentication/presentation/login/controllers/login_controller.dart';
import '../../features/authentication/presentation/login/login_page.dart';
import '../../features/chat/chat/application/bloc/chat_bloc.dart' as chat_bloc;
import '../../features/chat/chat/domain/entities/chat_entity.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../di/di.dart';
import '../services/session_manager.dart';
import '../usecases/base_usecase.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: sl<SessionManager>(),
  redirect: (context, state) {

    final authStatus = sl<SessionManager>().value;
    // If we are still initializing, stay on the splash
    if (authStatus == AuthStatus.unknown) return AppRoutes.splash;

    // Define which routes anyone can see
    final isPublicRoute = state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.register;

    // If not authenticated, route to login
    if (authStatus == AuthStatus.unauthenticated) {
      // If the user trying to go to a public route, let the user route gracefully
      // Otherwise, force the user to the login page
      return isPublicRoute ? null : AppRoutes.login;
    }

    // If authenticated, prevent the user from seeing login/register/splash
    if (authStatus == AuthStatus.authenticated) {
      if (isPublicRoute || state.matchedLocation == AppRoutes.splash) {
        return AppRoutes.home;
      }
      return null;
    }

    // Return null allows the user to stay on the current page
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      name: AppRoutes.login,
      path: AppRoutes.login,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: RepositoryProvider(
          create: (context) => LoginController(),
          dispose: (controller) => controller.dispose(),
          child: BlocProvider(
            create: (context) => LoginBloc(
              loginUseCase: sl<BaseUsecase<AuthEntity, LoginParam>>(),
            ),
            child: LoginPage(),
          ),
        ),
      ),
    ),
    GoRoute(
      name: AppRoutes.register,
      path: AppRoutes.register,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: RepositoryProvider<RegisterController>(
          create: (context) => RegisterController(),
          dispose: (controller) => controller.dispose(),
          child: BlocProvider(
            create: (context) => RegisterBloc(),
            child: RegisterPage(),
          ),
        ),
      ),
    ),
    GoRoute(
      name: AppRoutes.home,
      path: AppRoutes.home,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (context) => chat_bloc.ChatBloc(
            listChatUseCase: sl<BaseUsecase<ChatEntity, Unit>>(),
            client: sl<InboxWsClient>(),
            userStorage: sl<IUserStorage>(),
          )..add(chat_bloc.ConnectToInbox()),
          child: HomePage(),
        ),
      ),
    ),
    GoRoute(
      name: AppRoutes.splash,
      path: AppRoutes.splash,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: SplashPage(),
      ),
    ),
    GoRoute(
      name: AppRoutes.chatMessage,
      path: AppRoutes.chatMessage,
      pageBuilder: (context, state) {
        final ChatResultEntity chatResult = state.extra as ChatResultEntity;
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: RepositoryProvider<MessageController>(
            create: (context) => MessageController(),
            dispose: (controller) => controller.dispose(),
            child: BlocProvider(
              create: (context) => ChatBloc(
                client: sl<WebSockentClient>(),
                receiverId: chatResult.recipient.userId,
                chatMessageUsecase: sl<BaseUsecase<ChatMessageEntity, ChatMessageParam>>(),
                chatMessageListUseCase: sl<BaseUsecase<PaginatedMessages, String?>>(),
                chatSocketService: sl<ChatSocketService>(),
              )..add(ConnectToChat()),
              child: ChatMessagePage(chatEntity: chatResult),
            ),
          ),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.appearance,
      path: AppRoutes.appearance,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: AppearancePage(),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.chatGroup,
      path: AppRoutes.chatGroup,
      pageBuilder: (context, state) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => ChatGroupBloc()..add(LoadMembers()),
            child: ChatGroupPage(),
          ),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.chatGroupDetails,
      path: AppRoutes.chatGroupDetails,
      pageBuilder: (context, state) {
        final List<GroupMemberEntity> members =
            state.extra as List<GroupMemberEntity>;
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: ChatGroupDetailsPage(members: members),
        );
      },
    ),
  ],
);

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
