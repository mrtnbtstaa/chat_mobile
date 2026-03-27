import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_recipient.dart';

class ChatRecipientResponseDto extends ChatRecipient{
  
  const ChatRecipientResponseDto({
    required super.userId,
    required super.username,
    required super.displayFullName,
    super.profileImage,
    required super.isOnline
  });

  factory ChatRecipientResponseDto.fromJson(Map<String, dynamic> json){

    final recipient = json["recipient"];

    return ChatRecipientResponseDto(
      userId: recipient["user_id"],
      username: recipient["username"],
      displayFullName: recipient["display_full_name"],
      profileImage: recipient["profile_image"] ?? "",
      isOnline: recipient["is_online"]
    );
  }

}