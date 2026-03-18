import 'package:flutter/material.dart';

import 'core/common_widgets/common_loading_indicator.dart';
import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'core/services/session_manager.dart';
import 'features/authentication/presentation/login/login_page.dart';
import 'features/home/presentation/home_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  sl<SessionManager>().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: ValueListenableBuilder(
        valueListenable: sl<SessionManager>(),
        builder:(context, status, child) {
          if(status == AuthStatus.unauthenticated) return const LoginPage();
          if(status == AuthStatus.authenticated) return const HomePage();
          return CommonLoadingIndicator();
        },
      ),
    );
  }
}


