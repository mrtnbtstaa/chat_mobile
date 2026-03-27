import 'package:chat/features/chat/chat/infrastructure/datasources/inbox_ws_client.dart';

import '../../features/chat/chat_message/infrastructure/datasources/web_sockent_client.dart';
import '../../features/chat/chat_message/application/usecases/chat_message_usecase.dart';
import '../../features/chat/chat_message/application/usecases/list_chat_messages_usecase.dart';
import '../../features/chat/chat_message/domain/entities/chat_message_entity.dart';
import '../../features/chat/chat_message/domain/entities/paginated_messages.dart';
import '../../features/chat/chat_message/domain/params/chat_message_param.dart';
import '../../features/chat/chat_message/domain/repositories/i_chat_message_repository.dart';
import '../../features/chat/chat_message/infrastructure/datasources/chat_message_remote_data_source.dart';
import '../../features/chat/chat_message/infrastructure/datasources/i_chat_message_remote_data_source.dart';
import '../../features/chat/chat_message/infrastructure/repositories/chat_message_repository_impl.dart';
import '../../features/chat/chat_message/infrastructure/services/chat_socket_service.dart';

import '../contracts/i_local_storage.dart';
import '../contracts/i_token_storage.dart';
import '../contracts/i_user_storage.dart';
import '../../features/authentication/application/usecase/logout_usecase.dart';
import '../../features/authentication/domain/params/access_token_param.dart';
import '../../features/authentication/infrastructure/datasources/local/local_shared_prefs_storage.dart';
import '../../features/authentication/infrastructure/datasources/local/user_local_data_source_impl.dart';
import '../../features/chat/chat/application/usecases/list_chat_usecase.dart';
import '../../features/chat/chat/domain/entities/chat_entity.dart';
import '../../features/chat/chat/domain/repositories/i_chat_repository.dart';
import '../../features/chat/chat/infrastructure/datasources/remote/chat_remote_data_source_impl.dart';
import '../../features/chat/chat/infrastructure/datasources/remote/i_chat_remote_data_source.dart';
import '../../features/chat/chat/infrastructure/repositories/chat_repository_impl.dart';

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
import '../../features/authentication/infrastructure/datasources/remote/auth_remote_data_source_impl.dart';
import '../../features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import '../../features/authentication/infrastructure/repositories/auth_repository_impl.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/expired_retry_token_policy.dart';
import '../services/session_manager.dart';
import '../usecases/base_usecase.dart';

final sl = GetIt.instance;

void initDependencies() {
  _websocketClient();
  _externalDependencies();
  _registerAuthDependencies();
  _chatDependencies();
  _chatMessageDependencies();
}

void _externalDependencies(){
  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  // Auth interceptor
  sl.registerLazySingleton(() => AuthInterceptor(sl<ITokenStorage>(), sl<SessionManager>()));

  sl.registerLazySingleton<Client>(() => InterceptedClient.build(
    interceptors: [sl<AuthInterceptor>()],
    retryPolicy: ExpiredRetryTokenPolicy(sl<AuthInterceptor>()),
  ), instanceName: 'interceptedClient');
}

void _registerAuthDependencies(){

  sl.registerLazySingleton(() => SessionManager(sl<ITokenStorage>(), sl<IUserStorage>()));

  sl.registerLazySingleton<Client>(() => Client(), instanceName: 'cleanClient');

  // Data sources
  sl.registerLazySingleton<IRemoteAuthDataSource>(() => AuthRemoteDataSourceImpl(client: sl<Client>(instanceName: 'cleanClient')));
  sl.registerLazySingleton<ITokenStorage>(() => AuthLocalDataSourceImpl(sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<ILocalStorage>(() => LocalSharedPrefsStorage());
  sl.registerLazySingleton<IUserStorage>(() => UserLocalDataSourceImpl(sl()));
  
  // Repositories
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl<IRemoteAuthDataSource>(), sl<ITokenStorage>(), sl<IUserStorage>()));
  
  // Usecases
  sl.registerLazySingleton<BaseUsecase<AuthEntity, LoginParam>>(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, RegisterParam>>(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<TokenEntity, RefreshTokenParam>>(() => RefreshTokenUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, AccessTokenParam>>(() => VerifyTokenUsecase(authRepository: sl()));
  sl.registerLazySingleton<BaseUsecase<Unit, String>>(() => LogoutUsecase(authRepository: sl()));
}


void _chatDependencies(){

  // Data sources
  sl.registerLazySingleton<IChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(client: sl<Client>(instanceName: 'interceptedClient'), storage: sl<ITokenStorage>()));

  // Repositories
  sl.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton<BaseUsecase<ChatEntity, Unit>>(() => ListChatUsecase(sl()));

}

void _chatMessageDependencies(){

  // Data sources
  sl.registerLazySingleton<IChatMessageRemoteDataSource>(() => ChatMessageRemoteDataSource(client: sl<Client>(instanceName: 'interceptedClient')));
  sl.registerLazySingleton(() => ChatSocketService(sl<WebSockentClient>(), sl<IUserStorage>()));

  // Repositories
  sl.registerLazySingleton<IChatMessageRepository>(() => ChatMessageRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton<BaseUsecase<ChatMessageEntity, ChatMessageParam>>(() => ChatMessageUsecase(sl()));
  sl.registerLazySingleton<BaseUsecase<PaginatedMessages, String?>>(() => ListChatMessagesUsecase(sl()));
}

void _websocketClient(){
  sl.registerLazySingleton(() => WebSockentClient());
  sl.registerLazySingleton(() => InboxWsClient());
}