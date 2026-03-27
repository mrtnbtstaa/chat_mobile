class ChatMessageRequestDto {

  final String text;
  final String recipientId;

  const ChatMessageRequestDto({
    required this.text,
    required this.recipientId
  });


  Map<String, dynamic> toJson() => {
    "text": text,
    "recipient_id": recipientId
  };

}