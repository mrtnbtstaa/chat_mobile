import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test('Should return a valid model from json', () {

    // Arrange
    final Map<String, dynamic> jsonMap = {
      "previous": "",
      "next": "",
      "results": [
        {
          "id": "ca3ddee0-7e28-421e-bda6-5ca1cac7dc24",
          "room_type": "DIRECT",
          "display_name": "martin18",
          "display_image": "http://192.168.100.47:8000/GAME_MENU.png",
          "last_message": {
              "text": "bro?qqweqwewqe",
              "sender": "martin24",
              "last_message_at": "2026-03-22T03:22:21.701548Z"
          },
          "created_at": "2026-03-21T16:05:42.012980Z"
        }
      ]
    };

    // Act
    final result = ChatResponseDto.fromJson(jsonMap);
    final firstResult = result.results.first;

    // Assert
    expect(result.previous, "");
    expect(result.next, "");
    expect(firstResult.id, "ca3ddee0-7e28-421e-bda6-5ca1cac7dc24");
    expect(firstResult.roomType, "DIRECT");
    expect(firstResult.displayName, "martin18");
    expect(firstResult.displayImage, "http://192.168.100.47:8000/GAME_MENU.png");
    expect(firstResult.createdAt, "2026-03-21T16:05:42.012980Z");
    expect(firstResult.lastMessage.text, "bro?qqweqwewqe");
    expect(firstResult.lastMessage.sender, "martin24");
    expect(firstResult.lastMessage.lastMessageAt, "2026-03-22T03:22:21.701548Z");

  });

}