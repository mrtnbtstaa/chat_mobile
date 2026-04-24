

import 'package:chat/features/chat/chat_group/application/usecases/list_group_chat_usecase.dart';
import 'package:chat/features/chat/chat_group/infrastructure/remote/group_member_remote_data_source_impl.dart';
import 'package:chat/features/chat/chat_group/infrastructure/remote/i_group_member_remote_data_source.dart';
import 'package:chat/features/chat/chat_group/infrastructure/repositories/group_member_repository_impl.dart';
import 'package:chat/features/chat/chat_group/models/entities/group_member_entity.dart';
import 'package:chat/features/chat/chat_group/models/entities/paginated_group_member.dart';
import 'package:chat/features/chat/chat_group/models/repositories/i_group_member_repository.dart';

import 'di_exports.dart';

final sl = GetIt.instance;

void initDependencies() {
  _websocketClient();
  _externalDependencies();
  _registerAuthDependencies();
  _chatDependencies();
  _chatGroupDependencies();
  _chatMessageDependencies();
  _profileDependencies();
  _changePasswordDependencies();
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

  sl.registerLazySingleton(() => MediaService());
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
  sl.registerLazySingleton<BaseUsecase<ChatEntity, Unit>>(() => ListChatUsecase(sl()), instanceName: 'listChat');
  sl.registerLazySingleton<BaseUsecase<ChatEntity, Unit>>(() => ListChatUserStatusUsecase(sl()), instanceName: 'listUserStatus');
}

void _chatMessageDependencies(){
  // Data sources
  sl.registerLazySingleton<IChatMessageRemoteDataSource>(() => ChatMessageRemoteDataSource(client: sl<Client>(instanceName: 'interceptedClient')));
  sl.registerLazySingleton(() => ChatSocketService(sl<WebSockentClient>(), sl<IUserStorage>()));
  // Repositories
  sl.registerLazySingleton<IChatMessageRepository>(() => ChatMessageRepositoryImpl(sl()));
  // Usecases
  sl.registerLazySingleton<BaseUsecase<Unit, ChatMessageParam>>(() => SendMessageUsecase(sl()));
  sl.registerLazySingleton<BaseUsecase<PaginatedMessages, String?>>(() => ListChatMessagesUsecase(sl()));
}

void _chatGroupDependencies(){
  sl.registerLazySingleton<IGroupMemberRemoteDataSource>(() => GroupMemberRemoteDataSourceImpl(client: sl<Client>(instanceName: 'interceptedClient')));
  sl.registerLazySingleton<IGroupMemberRepository>(() => GroupMemberRepositoryImpl(sl()));
  sl.registerLazySingleton<BaseUsecase<PaginatedGroupMember, String?>>(() => ListGroupChatUsecase(sl()));
}

void _websocketClient(){
  sl.registerLazySingleton(() => WebSockentClient());
  sl.registerLazySingleton(() => InboxWsClient());
}

void _profileDependencies(){
  // Data sources
  sl.registerLazySingleton<IUploadRemoteDataSource>(() => UploadRemouteDataSourceImpl(client: sl<Client>(instanceName: 'interceptedClient')));
  // Repositories
  sl.registerLazySingleton<IProfileRepository>(() => ProfileRepositoryImpl(sl<IUploadRemoteDataSource>(), sl<IUserStorage>()));
  // Usecases
  sl.registerLazySingleton<BaseUsecase<ProfileEntity, ProfileParam>>(() => UploadProfileUsecase(sl<IProfileRepository>()));
}

void _changePasswordDependencies(){
  // Data sources
  sl.registerLazySingleton<IPasswordRemoteDataSource>(() => PasswordRemoteDataSource(client: sl<Client>(instanceName: 'interceptedClient')));
  // Repositories
  sl.registerLazySingleton<IPasswordRepository>(() => PasswordRepositoryImpl(sl<IPasswordRemoteDataSource>()));
  // Usecases
  sl.registerLazySingleton<BaseUsecase<Unit, PasswordParam>>(() => ChangePasswordUsecase(sl<IPasswordRepository>()));
}