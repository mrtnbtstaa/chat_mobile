class ChatLastMessage{

  final String? messageId;
  final String? text;
  final String? sender;
  final String? lastMessageAt;

  const ChatLastMessage({
    required this.messageId,
    required this.text,
    required this.sender,
    required this.lastMessageAt
  });

  factory ChatLastMessage.fromJson(Map<String, dynamic> json){
    return ChatLastMessage(
      messageId: json["message_id"] ?? "",
      text: json["text"] ?? "",
      sender: json["sender"] ?? "",
      lastMessageAt: json["last_message_at"] ?? ""
    );
  }

  ChatLastMessage copyWith({String? text, String? lastMessageAt}){
    return ChatLastMessage(
      messageId: messageId,
      text: text ?? this.text,
      sender: sender,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt
    );
  }

}