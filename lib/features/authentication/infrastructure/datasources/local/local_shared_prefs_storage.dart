import 'package:chat/core/contracts/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPrefsStorage implements ILocalStorage {
  @override
  Future<String?> getString(String key) {
    return SharedPreferences.getInstance()
      .then((pref) => pref.getString(key));
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}