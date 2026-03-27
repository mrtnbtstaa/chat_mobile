abstract interface class ILocalStorage {
  Future<void> saveString(String key, String value);
  Future<void> saveBool(String key, bool value);
  Future<String?> getString(String key);
  Future<bool?> getBool(String key);
  Future<void> clear();
}