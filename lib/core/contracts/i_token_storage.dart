abstract interface class ITokenStorage {

  Future<void> cacheToken(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();


}