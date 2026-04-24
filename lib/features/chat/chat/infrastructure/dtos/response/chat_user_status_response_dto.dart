import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_result_user_status_response_dto.dart';

class ChatUserStatusResponseDto extends ChatEntity {

  const ChatUserStatusResponseDto({
    super.previous,
    super.next,
    required super.results
  });

  factory ChatUserStatusResponseDto.fromJson(Map<String, dynamic> json){
    return ChatUserStatusResponseDto(
      previous: json["previous"] ?? "",
      next: json["next"] ?? "",
      results: (json["results"] as List).map((c) => ChatResultUserStatusResponseDto.fromJson(c)).toList()
    );
  }

  ChatEntity toEntity() => this;
}
