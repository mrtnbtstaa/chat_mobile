abstract interface class IUserStorage {

  Future<void> saveUser(
    String userId,
    String username,
    String firstname,
    String lastname,
    String? profileImage,
    bool isOnline
  );
  Future<String?> getUserInfo(String key);
  Future<bool?> getUserStatus(String key);
  Future<void> clearUser();

}