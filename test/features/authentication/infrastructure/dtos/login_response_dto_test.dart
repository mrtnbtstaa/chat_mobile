import 'package:chat/features/authentication/infrastructure/dtos/response/login_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Should return a valid model from json', () {
    // Arrange
    final Map<String, dynamic> jsonMap = {
      "user_id": "1",
      "username": "martin",
      "tokens": {
        "access_token": "access123",
        "refresh_token": "refresh123",
      },
      "profile": "image.png"
    };

    // Act
    final result = LoginResponseDto.fromJson(jsonMap);

    // Assert
    expect(result.userId, "1");
    expect(result.tokens.accessToken, "access123");
    expect(result.tokens.refreshToken, "refresh123");
    expect(result.email, "martin");
    expect(result.profile, "image.png");
  });
}