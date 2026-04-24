import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_result_response_dto.dart';

class ChatResponseDto extends ChatEntity {

  const ChatResponseDto({
    super.previous,
    super.next,
    required super.results
  });

  factory ChatResponseDto.fromJson(Map<String, dynamic> json){
    return ChatResponseDto(
      previous: json["previous"] ?? "",
      next: json["next"] ?? "",
      results: (json["results"] as List).map((c) => ChatResultResponseDto.fromJson(c)).toList()
    );
  }

  ChatEntity toEntity() => this;
}
