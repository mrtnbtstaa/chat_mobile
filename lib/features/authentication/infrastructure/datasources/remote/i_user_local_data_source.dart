abstract interface class IUserLocalDataSource {

  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearUserId();

}