import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:chat/features/chat/chat_message/domain/entities/paginated_messages.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IChatMessageRepository {
  Future<Either<Failure, ChatMessageEntity>> sendMessage(String content, String recipientId);
  Future<Either<Failure, PaginatedMessages>> messages(String? cursorUrl);
}