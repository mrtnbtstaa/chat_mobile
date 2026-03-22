abstract interface class ILocalAuthDataSource {
  Future<void> cacheToken(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}