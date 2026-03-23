import 'chat_last_message.dart';

class ChatResultEntity {

  final String id;
  final String roomType;
  final String displayName;
  final String displayImage;
  final String createdAt;
  final ChatLastMessage lastMessage;

  const ChatResultEntity({
    required this.id,
    required this.roomType,
    required this.displayName,
    required this.displayImage,
    required this.createdAt,
    required this.lastMessage
  });

  factory ChatResultEntity.fromJson(Map<String, dynamic> json) {
    return ChatResultEntity(
      id: json["id"],
      roomType: json["room_type"],
      displayName: json["display_name"],
      displayImage: json["display_image"],
      createdAt: json["created_at"],
      lastMessage: ChatLastMessage.fromJson(json["last_message"])
    );
  }

}

