import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat_message/domain/entities/paginated_messages.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IChatMessageRepository {
  Future<Either<Failure, Unit>> sendMessage(String content, String recipientId);
  Future<Either<Failure, PaginatedMessages>> messages(String? cursorUrl);
}