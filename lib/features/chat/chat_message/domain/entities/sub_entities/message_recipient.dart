class MessageRecipient {

  final String? profileImage;
  final bool isOnline;
  final String sender;
  final String senderId;
  final bool sentByMe; 

  const MessageRecipient({
    required this.profileImage,
    required this.isOnline,
    required this.sender,
    required this.senderId,
    required this.sentByMe
  });

  factory MessageRecipient.fromJson(Map<String, dynamic> json){

    final recipient = json["recipient"];

    return MessageRecipient(
      profileImage: recipient["profile_image"] ?? "",
      isOnline: recipient["is_online"],
      sender: recipient["sender"],
      senderId: recipient["sender_id"],
      sentByMe: recipient["sent_by_me"]
    );
  }

}