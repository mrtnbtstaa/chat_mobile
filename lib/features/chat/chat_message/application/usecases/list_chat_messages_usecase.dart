import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat_message/domain/entities/paginated_messages.dart';
import 'package:chat/features/chat/chat_message/domain/repositories/i_chat_message_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListChatMessagesUsecase extends BaseUsecase<PaginatedMessages, String?>{

  final IChatMessageRepository _chatMessageRepository;
  ListChatMessagesUsecase(this._chatMessageRepository);
  @override
  Future<Either<Failure, PaginatedMessages>> call(String? param) async => _chatMessageRepository.messages(param);
 
}