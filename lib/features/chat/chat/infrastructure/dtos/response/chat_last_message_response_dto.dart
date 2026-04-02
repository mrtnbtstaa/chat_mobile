import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_last_message.dart';

class ChatLastMessageResponseDto extends ChatLastMessage{

  const ChatLastMessageResponseDto({
    required super.messageId,
    required super.text,
    required super.sender,
    required super.lastMessageAt
  });


  factory ChatLastMessageResponseDto.fromJson(Map<String, dynamic> json){
    final lastMessage = json["last_message"];
    return ChatLastMessageResponseDto(
      messageId: lastMessage["message_id"] ?? "",
      text: lastMessage["text"] ?? "",
      sender: lastMessage["sender"] ?? "",
      lastMessageAt: DateTime.parse(lastMessage["last_message_at"])
    );
  }

}