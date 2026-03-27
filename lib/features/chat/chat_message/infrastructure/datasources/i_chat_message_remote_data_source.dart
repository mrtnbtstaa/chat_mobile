import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat_message/infrastructure/dtos/request/chat_message_request_dto.dart';
import 'package:chat/features/chat/chat_message/infrastructure/dtos/response/chat_message_response_dto.dart';
import 'package:chat/features/chat/chat_message/infrastructure/dtos/response/paginated_chat_message_response_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IChatMessageRemoteDataSource {

  Future<Either<Failure, ChatMessageResponseDto>> sendMessage(ChatMessageRequestDto chatMessageDto);
  Future<Either<Failure, PaginatedChatMessageResponseDto<ChatMessageResponseDto>>> getMessages(String? cursorUrl);
  
}