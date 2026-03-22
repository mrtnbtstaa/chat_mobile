import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_result_entity.dart';

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
      results: json["results"] != null ? 
      (json["results"] as List).map((i) => ChatResultEntity.fromJson(i)).toList()
      : []
    );
  }

  ChatEntity toEntity() => this;

}
