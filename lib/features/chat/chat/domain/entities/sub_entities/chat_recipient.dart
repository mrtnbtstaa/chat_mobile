class ChatRecipient {

  final String userId;
  final String username;
  final String displayFullName;
  final String? profileImage;
  final bool isOnline;

  const ChatRecipient({
    required this.userId,
    required this.username,
    required this.displayFullName,
    this.profileImage,
    required this.isOnline
  });

  factory ChatRecipient.fromJson(Map<String, dynamic> json){
    return ChatRecipient(
      userId: json["user_id"],
      username: json["username"],
      displayFullName: json["display_full_name"],
      profileImage: json["profile_image"],
      isOnline: json["is_online"]
    );
  }

}