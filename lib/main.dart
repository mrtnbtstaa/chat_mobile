import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:chat/core/utils/shared_preferences_manager.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/authentication/application/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'core/di/di.dart';
import 'core/resources/app_config.dart';
import 'core/resources/environment.dart';
import 'core/router/app_router.dart';
import 'core/services/session_manager.dart';
import 'core/utils/flutter_secure_storage_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.initialize(
    baseUrl: Environment.getBaseUrl,
    baseUrlWs: Environment.getBaseUrlWs,
    environment: Environment.getEnv,
  );

  initDependencies();

  FlutterSecureStorageManager.initialize(sl<FlutterSecureStorage>());
  await SharedPreferencesManager.initialize();
  await sl<SessionManager>().initialize();

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        logoutUseCase: sl<BaseUsecase<Unit, String>>(),
        tokenStorage: sl<ITokenStorage>()
      ),
      child: const MyApp()
    )
  );

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
