import 'package:chat/core/constants/api_constant.dart';
import 'package:chat/core/utils/shared_preferences_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final SharedPreferences sp = await SharedPreferences.getInstance();
  FlutterSecureStorageManager.initialize(sl<FlutterSecureStorage>());
  SharedPreferencesManager.initialize(sp);
  await sl<SessionManager>().initialize();

  if(kDebugMode){
    print("Userid: ${SharedPreferencesManager.instance?.getString("user_id")}");
  }

  runApp(const MyApp());
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
