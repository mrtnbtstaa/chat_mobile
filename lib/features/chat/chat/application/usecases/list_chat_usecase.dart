import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/repositories/i_chat_repository.dart';
import 'package:fpdart/fpdart.dart';


class ListChatUsecase implements BaseUsecase<ChatEntity, Unit>{

  final IChatRepository _chatRepository;
  
  ListChatUsecase(this._chatRepository);

  @override
  Future<Either<Failure, ChatEntity>> call(Unit _) async => _chatRepository.chats();
}