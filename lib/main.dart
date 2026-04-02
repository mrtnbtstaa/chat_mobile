import 'package:chat/core/common/bloc/theme_bloc.dart';
import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/features/settings/application/bloc/settings_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'core/config/app_config.dart';
import 'core/config/environment.dart';
import 'core/contracts/i_token_storage.dart';
import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'core/services/session_manager.dart';
import 'core/style/app_theme.dart';
import 'core/usecases/base_usecase.dart';
import 'core/utils/settings_manager.dart';
import 'features/authentication/application/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.initialize(
    baseUrl: Environment.getBaseUrl,
    baseUrlWs: Environment.getBaseUrlWs,
    environment: Environment.getEnv,
  );

  initDependencies();

  await SettingsManager().initialize();
  await sl<SessionManager>().initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            logoutUseCase: sl<BaseUsecase<Unit, String>>(),
            tokenStorage: sl<ITokenStorage>(),
          ),
        ),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkmode = state.currentTheme == AppTheme.dark;
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingState) {
            return MaterialApp.router(
              routerConfig: router,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDarkmode
                  ? ThemeMode.dark
                  : ThemeMode.light,

              builder: (context, child) {
                double scaleFactor = (0.99 + (settingState.fontSizeSliderValue * 0.5)).clamp(0.99, 1.25);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scaleFactor)),
                  child: child ?? SizedBox.shrink()
                );
              }
            );
          }
        );
      }
    );
  }
}
