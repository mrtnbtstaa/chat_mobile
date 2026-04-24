import 'package:chat/features/chat/chat_group/models/entities/group_member_entity.dart';

class GroupChatResultResponseDto extends GroupMemberEntity {

  const GroupChatResultResponseDto({
    required super.userId,
    required super.profileAvatar,
    required super.fullName,
    required super.isOnline,
  });

  factory GroupChatResultResponseDto.fromJson(Map<String, dynamic> json){
    return GroupChatResultResponseDto(
      fullName: json["full_name"],
      userId: json["user_id"],
      isOnline: json["is_online"],
      profileAvatar: json["profile_image"]
    );
  }


}