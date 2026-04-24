import '../../../domain/entities/sub_entities/chat_result_entity.dart';
import 'chat_last_message_response_dto.dart';
import 'chat_recipient_response_dto.dart';

class ChatResultResponseDto extends ChatResultEntity{

  const ChatResultResponseDto({
    required super.id,
    required super.roomType,
    required super.createdAt,
    required super.unreadCount,
    required super.recipient,
    required super.lastMessage
  });

  factory ChatResultResponseDto.fromJson(Map<String, dynamic> json){
    return ChatResultResponseDto(
      id: json["chat_id"],
      roomType: json["room_type"],
      createdAt: DateTime.parse(json["created_at"] ?? ""),
      unreadCount: json["unread_count"] ?? 0,
      recipient: ChatRecipientResponseDto.fromJson(json),
      lastMessage: ChatLastMessageResponseDto.fromJson(json)
    );
  }

}