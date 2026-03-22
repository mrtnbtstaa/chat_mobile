import 'package:chat/features/authentication/application/usecase/logout_usecase.dart';
import 'package:chat/features/authentication/domain/params/access_token_param.dart';
import 'package:chat/features/chat/chat/application/usecases/list_chat_usecase.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/params/user_id_param.dart';
import 'package:chat/features/chat/chat/domain/repositories/i_chat_repository.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/remote/chat_remote_data_source_impl.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/remote/i_chat_remote_data_source.dart';
import 'package:chat/features/chat/chat/infrastructure/repositories/chat_repository_impl.dart';

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
  _externalDependencies();
  _registerAuthDependencies();
  _chatDependencies();
}

void _externalDependencies(){
  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}

void _registerAuthDependencies(){

  sl.registerLazySingleton(() => SessionManager(sl<ILocalAuthDataSource>()));

  // Auth interceptor
  sl.registerLazySingleton(() => AuthInterceptor(sl<FlutterSecureStorage>(), sl<SessionManager>()));

  sl.registerLazySingleton<Client>(() => InterceptedClient.build(
    interceptors: [sl<AuthInterceptor>()],
    retryPolicy: ExpiredRetryTokenPolicy(sl<AuthInterceptor>()),
  ), instanceName: 'interceptedClient');


  sl.registerLazySingleton<Client>(() => Client(), instanceName: 'cleanClient');

  // Data sources
  sl.registerLazySingleton<IRemoteAuthDataSource>(() => AuthRemoteDataSourceImpl(client: sl<Client>(instanceName: 'cleanClient')));
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


void _chatDependencies(){

  // Data sources
  sl.registerLazySingleton<IChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(client: sl<Client>(instanceName: 'interceptedClient')));

  // Repositories
  sl.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(chatRemoteDataSource: sl()));

  // Usecases
  sl.registerLazySingleton<BaseUsecase<List<ChatEntity>, UserIdParam>>(() => ListChatUsecase(chatRepository: sl()));

}