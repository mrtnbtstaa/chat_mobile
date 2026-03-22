import 'package:chat/features/authentication/application/usecase/logout_usecase.dart';
import 'package:chat/features/authentication/domain/params/access_token_param.dart';

import '../../features/authentication/application/usecase/refresh_token_usecase.dart';
import '../../features/authentication/domain/entities/token_entity.dart';
import '../../features/authentication/domain/params/refresh_token_param.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../features/authentication/application/usecase/login_usecase.dart';
import '../../features/authentication/application/usecase/register_usecase.dart';
import '../../features/authentication/application/usecase/verify_token_usecase.dart';
import '../../features/authentication/domain/entities/auth_entity.dart';
import '../../features/authentication/domain/params/login_param.dart';
import '../../features/authentication/domain/params/register_param.dart';
import '../../features/authentication/domain/repositories/i_auth_repository.dart';
import '../../features/authentication/infrastructure/datasources/local/auth_local_data_source_impl.dart';
import '../../features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import '../../features/authentication/infrastructure/datasources/remote/auth_remote_data_source_impl.dart';
import '../../features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import '../../features/authentication/infrastructure/repositories/auth_repository_impl.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/expired_retry_token_policy.dart';
import '../services/session_manager.dart';
import '../usecases/base_usecase.dart';

final sl = GetIt.instance;

void initDependencies() {
  _authDependencies();
}

void _authDependencies(){
  // Core & External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => SessionManager(sl<ILocalAuthDataSource>()));

  // Auth interceptor
  sl.registerLazySingleton(() => AuthInterceptor(sl<FlutterSecureStorage>(), sl<SessionManager>()));

  sl.registerLazySingleton<Client>(() => InterceptedClient.build(
    interceptors: [sl<AuthInterceptor>()],
    retryPolicy: ExpiredRetryTokenPolicy(sl<AuthInterceptor>()),
  ), instanceName: 'interceptedClient');


  sl.registerLazySingleton<Client>(() => Client(), instanceName: 'refreshClient');

  // Data sources
  sl.registerLazySingleton<IRemoteAuthDataSource>(() => AuthRemoteDataSourceImpl(client: sl<Client>(instanceName: 'refreshClient')));
  sl.registerLazySingleton<ILocalAuthDataSource>(() => AuthLocalDataSourceImpl(flutterSecureStorage: sl<FlutterSecureStorage>()));
  
  // Repositories
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: sl(), authLocalDataSource: sl()));
  
  // Usecases
  sl.registerLazySingleton<BaseUsecase<AuthEntity, LoginParam>>(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, RegisterParam>>(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<TokenEntity, RefreshTokenParam>>(() => RefreshTokenUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, AccessTokenParam>>(() => VerifyTokenUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, String>>(() => LogoutUsecase(authRepository: sl()));
}