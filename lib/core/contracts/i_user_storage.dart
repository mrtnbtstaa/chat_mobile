abstract interface class IUserStorage {

  Future<void> saveUser(
    String userId,
    String email,
    String fullName,
    bool isOnline
  );

  Future<void> saveProfile(String profileImage);
  Future<String?> getUserInfo(String key);
  Future<bool?> getUserStatus(String key);
  Future<void> clearUser();

}