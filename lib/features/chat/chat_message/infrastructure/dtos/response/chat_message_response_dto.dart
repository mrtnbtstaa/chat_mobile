import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:chat/features/chat/chat_message/domain/entities/sub_entities/message_recipient.dart';

class ChatMessageResponseDto extends ChatMessageEntity {

  const ChatMessageResponseDto({
    required super.messageId,
    required super.content,
    required super.createdAt,
    required super.messageRecipient
  });

  factory ChatMessageResponseDto.fromJson(Map<String, dynamic> json){
    return ChatMessageResponseDto(
      messageId: json["id"],
      content: json["text"],
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      messageRecipient: MessageRecipient.fromJson(json)
    );
  }

  ChatMessageEntity toEntity() => this;

}