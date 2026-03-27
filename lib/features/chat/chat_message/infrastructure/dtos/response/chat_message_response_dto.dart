import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';

class ChatMessageResponseDto extends ChatMessageEntity {

  const ChatMessageResponseDto({
    required super.messageId,
    required super.content,
    required super.profileImage,
    required super.createdAt,
    required super.isOnline,
    required super.sender,
    required super.senderId,
    required super.sentByMe
  });

  factory ChatMessageResponseDto.fromJson(Map<String, dynamic> json){
    return ChatMessageResponseDto(
      messageId: json["id"],
      content: json["text"],
      profileImage: json["profile_image"] ?? "",
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      isOnline: json["is_online"],
      sender: json["sender"],
      senderId: json["sender_id"],
      sentByMe: json["sent_by_me"]
    );
  }

  ChatMessageEntity toEntity() => this;

}