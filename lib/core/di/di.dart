import 'package:chat/core/interceptors/interceptor_adapter.dart';

import '../interceptors/auth_interceptor.dart';
import '../services/session_manager.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../features/authentication/application/usecase/register_usecase.dart';
import '../../features/authentication/domain/params/register_param.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/application/usecase/login_usecase.dart';
import '../../features/authentication/domain/entities/auth_entity.dart';
import '../../features/authentication/domain/params/login_param.dart';
import '../../features/authentication/domain/repositories/i_auth_repository.dart';
import '../../features/authentication/infrastructure/datasources/local/auth_local_data_source_impl.dart';
import '../../features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import '../../features/authentication/infrastructure/datasources/remote/auth_remote_data_source_impl.dart';
import '../../features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import '../../features/authentication/infrastructure/repositories/auth_repository_impl.dart';
import '../usecases/base_usecase.dart';


final sl = GetIt.instance;


void initDependencies(){
  _registerAuthDependencies();
}

void _registerAuthDependencies(){
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<IRemoteAuthDataSource>(() => AuthRemoteDataSourceImpl(client: sl<InterceptedClient>()));
  sl.registerLazySingleton<ILocalAuthDataSource>(() => AuthLocalDataSourceImpl(flutterSecureStorage: sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl<IRemoteAuthDataSource>(), authLocalDataSource: sl<ILocalAuthDataSource>()));
  sl.registerLazySingleton<BaseUsecase<AuthEntity, LoginParam>>(() => LoginUsecase(authRepository: sl<IAuthRepository>()));
  sl.registerLazySingleton<BaseUsecase<Unit, RegisterParam>>(() => RegisterUsecase(authRepository: sl<IAuthRepository>()));
  sl.registerLazySingleton(() => AuthInterceptor(sl<FlutterSecureStorage>(), sl<SessionManager>(), sl<IRemoteAuthDataSource>()));
  sl.registerLazySingleton(() => SessionManager(sl<ILocalAuthDataSource>()));
  sl.registerLazySingleton<InterceptedClient>(() => InterceptedClient.build(
    interceptors: [InterceptorAdapter(sl<AuthInterceptor>())],
  ));
}