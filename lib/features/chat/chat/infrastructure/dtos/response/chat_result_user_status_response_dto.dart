import '../../../domain/entities/sub_entities/chat_result_entity.dart';
import 'chat_recipient_response_dto.dart';

class ChatResultUserStatusResponseDto extends ChatResultEntity{

  const ChatResultUserStatusResponseDto({
    required super.id,
    required super.roomType,
    required super.createdAt,
    required super.recipient,
  });

  factory ChatResultUserStatusResponseDto.fromJson(Map<String, dynamic> json){
    return ChatResultUserStatusResponseDto(
      id: json["chat_id"],
      roomType: json["room_type"],
      createdAt: DateTime.parse(json["created_at"] ?? ""),
      recipient: ChatRecipientResponseDto.fromJson(json),
    );
  }

}