import 'package:chat/features/chat/chat/application/bloc/chat_bloc.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/params/user_id_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/application/login/bloc/login_bloc.dart';
import '../../features/authentication/domain/entities/auth_entity.dart';
import '../../features/authentication/domain/params/login_param.dart';
import '../../features/authentication/presentation/login/controllers/login_controller.dart';
import '../../features/authentication/presentation/login/login_page.dart';
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

    // If not logged in and not on the login page, force move to login
    if (authStatus == AuthStatus.unauthenticated) return AppRoutes.login;

    // If logged in and trying to go to login or splash, move to home
    if (authStatus == AuthStatus.authenticated) return AppRoutes.home;

    // Return null allows the user to stay on the current page
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
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
      path: AppRoutes.home,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (context) => ChatBloc(
            listChatUseCase: sl<BaseUsecase<List<ChatEntity>, UserIdParam>>()
          ),
          child: HomePage(),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: SplashPage(),
      ),
    ),
  ],
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
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
