abstract interface class IUserStorage {

  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearUserId();

}