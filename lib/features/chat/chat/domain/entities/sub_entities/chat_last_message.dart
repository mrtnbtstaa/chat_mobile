class ChatLastMessage{

  final String text;
  final String sender;
  final String lastMessageAt;

  const ChatLastMessage({
    required this.text,
    required this.sender,
    required this.lastMessageAt
  });

  factory ChatLastMessage.fromJson(Map<String, dynamic> json){
    return ChatLastMessage(
      text: json["text"],
      sender: json["sender"],
      lastMessageAt: json["last_message_at"]
    );
  }

}