import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_recipient.dart';

import 'chat_last_message.dart';

class ChatResultEntity {

  final String id;
  final String roomType;
  final DateTime createdAt;
  final int unreadCount;
  final ChatRecipient recipient;
  final ChatLastMessage? lastMessage;

  const ChatResultEntity({
    required this.id,
    required this.roomType,
    required this.createdAt,
    this.unreadCount = 0,
    required this.recipient,
    this.lastMessage
  });

  factory ChatResultEntity.fromJson(Map<String, dynamic> json) {
    return ChatResultEntity(
      id: json["chat_id"],
      roomType: json["room_type"],
      createdAt: DateTime.parse(json["created_at"]),
      unreadCount: json["unread_count"],
      recipient: ChatRecipient.fromJson(json["recipient"]),
      lastMessage: json["last_message"] != null ? ChatLastMessage.fromJson(json["last_message"]) : null
    );
  }

  ChatResultEntity copyWith({ChatLastMessage? lastMessage, int? unreadCount}){
    return ChatResultEntity(
      id: id,
      roomType: roomType,
      createdAt: createdAt,
      unreadCount: unreadCount ?? this.unreadCount,
      recipient: recipient,
      lastMessage: lastMessage ?? this.lastMessage
    );
  }

}

