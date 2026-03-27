import 'package:chat/core/resources/app_config.dart';
import 'package:chat/features/chat/chat_message/infrastructure/dtos/response/paginated_chat_message_response_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import '../dtos/request/chat_message_request_dto.dart';
import '../dtos/response/chat_message_response_dto.dart';
import 'i_chat_message_remote_data_source.dart';

class ChatMessageRemoteDataSource extends NetworkClient implements IChatMessageRemoteDataSource{

  ChatMessageRemoteDataSource({super.client});

  @override
  Future<Either<Failure, ChatMessageResponseDto>> sendMessage(ChatMessageRequestDto chatMessageDto) async =>
  await post(
    ApiConstant.chatMessageApi,
    body: chatMessageDto.toJson(),
    onSuccess: (json) => ChatMessageResponseDto.fromJson(json)
  );
  
  @override
  Future<Either<Failure, PaginatedChatMessageResponseDto<ChatMessageResponseDto>>> getMessages(String? cursorUrl) async {

    final String path = (cursorUrl != null && cursorUrl.isNotEmpty) ? cursorUrl : ApiConstant.listChatMessagesApi;

    return await get(
      path,
      onSuccess: (json){
        if (kDebugMode) print("Raw JSON: $json");
        return PaginatedChatMessageResponseDto<ChatMessageResponseDto>(
          next: json["next"],
          previous: json["previous"],
          results: (json["results"] as List? ?? [])
          .map((c) => ChatMessageResponseDto.fromJson(c))
          .toList()
        );
      }
    );
  }
    
}