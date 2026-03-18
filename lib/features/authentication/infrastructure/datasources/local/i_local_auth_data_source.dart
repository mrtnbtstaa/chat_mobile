import 'package:chat/features/authentication/infrastructure/dtos/token_dto.dart';

abstract interface class ILocalAuthDataSource {
  Future<TokenDto> cacheToken(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearAll();
}