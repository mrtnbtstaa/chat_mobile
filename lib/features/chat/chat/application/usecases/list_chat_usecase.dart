import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/params/user_id_param.dart';
import 'package:chat/features/chat/chat/domain/repositories/i_chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListChatUsecase implements BaseUsecase<List<ChatEntity>, UserIdParam>{

  final IChatRepository chatRepository;
  
  const ListChatUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, List<ChatEntity>>> call(UserIdParam param) async => chatRepository.chats(param.userId);
}