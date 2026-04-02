import 'package:chat/features/chat/chat_message/domain/entities/sub_entities/message_recipient.dart';
import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {

  final String messageId;
  final String content;
  final DateTime createdAt;
  final MessageRecipient messageRecipient;

  const ChatMessageEntity({
    required this.messageId,
    required this.content,
    required this.createdAt,
    required this.messageRecipient
  });

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json){

    print("Entity from json: $json");

    return ChatMessageEntity(
      messageId: json["id"],
      content: json["text"],
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      messageRecipient: MessageRecipient.fromJson(json)
    );
  }

  @override
  List<Object?> get props => [messageId, content, createdAt, messageRecipient];

}