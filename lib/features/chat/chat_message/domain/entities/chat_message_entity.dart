import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {

  final String messageId;
  final String content;
  final String? profileImage;
  final DateTime createdAt;
  final bool isOnline;
  final String sender;
  final String senderId;
  final bool sentByMe;  

  const ChatMessageEntity({
    required this.messageId,
    required this.content,
    required this.profileImage,
    required this.createdAt,
    required this.isOnline,
    required this.sender,
    required this.senderId,
    required this.sentByMe
  });

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json){

    print("Entity from json: $json");

    return ChatMessageEntity(
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

  @override
  List<Object?> get props => [messageId, content, profileImage, createdAt, isOnline, sender, senderId, sentByMe];

}