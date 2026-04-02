abstract interface class IUserStorage {

  Future<void> saveUser(
    String userId,
    String email,
    String fullName,
    String? profileImage,
    bool isOnline
  );
  Future<String?> getUserInfo(String key);
  Future<bool?> getUserStatus(String key);
  Future<void> clearUser();

}