import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:chat/features/chat/chat_message/domain/entities/paginated_messages.dart';
import 'package:chat/features/chat/chat_message/domain/repositories/i_chat_message_repository.dart';
import 'package:chat/features/chat/chat_message/infrastructure/datasources/i_chat_message_remote_data_source.dart';
import 'package:chat/features/chat/chat_message/infrastructure/dtos/request/chat_message_request_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class ChatMessageRepositoryImpl implements IChatMessageRepository{

  final IChatMessageRemoteDataSource _chatMessageRemoteDataSource;

  const ChatMessageRepositoryImpl(this._chatMessageRemoteDataSource);

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage(String content, String recipientId) async {

    // Create a request DTO
    final messageDto = ChatMessageRequestDto(text: content, recipientId: recipientId);
    
    print("Message request DTO: ${messageDto.toJson()}");

    // Get the message and capture the result
    final result = await _chatMessageRemoteDataSource.sendMessage(messageDto);

    return await result.fold(
      (failure) async{
        if(kDebugMode){
          print("Failure in the repository: ${failure.code}, ${failure.message}, ${failure.code}");
        }
        return left(failure);
      },
      (dto){
        if(kDebugMode){
          print("Success sa repository");
        }
        return right(dto.toEntity());
      }
    );

  }
  
  @override
  Future<Either<Failure, PaginatedMessages>> messages(String? cursorUrl) async {
    final result = await _chatMessageRemoteDataSource.getMessages(cursorUrl);
    return await result.fold(
      (failure) {
        if(kDebugMode){
          print("Failure: ${failure.message}, ${failure.error}, ${failure.statusCode}");
        }
        return left(failure);
      }, 
      (dto) => right(dto.toEntity())
    );

  }
}