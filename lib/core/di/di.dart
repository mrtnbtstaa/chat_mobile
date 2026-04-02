import 'di_exports.dart';

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
  sl.registerLazySingleton(() => MediaService());
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
