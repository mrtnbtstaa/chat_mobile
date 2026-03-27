import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:chat/features/chat/chat_message/domain/params/chat_message_param.dart';
import 'package:chat/features/chat/chat_message/domain/repositories/i_chat_message_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatMessageUsecase extends BaseUsecase<ChatMessageEntity, ChatMessageParam>{

  final IChatMessageRepository _chatMessageRepository;

  ChatMessageUsecase(this._chatMessageRepository);

  @override
  Future<Either<Failure, ChatMessageEntity>> call(ChatMessageParam param) async =>
  await _chatMessageRepository.sendMessage(param.content, param.recipientId);

}