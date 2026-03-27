import 'package:chat/features/authentication/infrastructure/dtos/response/login_response_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/refresh_token_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){

  test("LoginResponseDTO should map correctly to AuthEntity", (){
    // Arrange
    final dto = LoginResponseDto(
      userId: "123",
      tokens: RefreshTokenResponseDto(accessToken: "access123", refreshToken: "refresh123"),
      username: "martin18",
      profile: "qweqw.png"
    );

    // Act
    final entity = dto.toEntity();

    // Assert
    expect(entity.userId, equals(dto.userId));
    expect(entity.tokens.accessToken, equals(dto.tokens.accessToken));
    expect(entity.tokens.refreshToken, equals(dto.tokens.refreshToken));
    expect(entity.username, equals(dto.username));
    expect(entity.profile, equals(dto.profile));

  });

}