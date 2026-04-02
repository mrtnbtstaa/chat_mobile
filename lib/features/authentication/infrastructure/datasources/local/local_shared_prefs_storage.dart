import 'package:chat/core/contracts/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPrefsStorage implements ILocalStorage {
  @override
  Future<String?> getString(String key) async {
    return await SharedPreferences.getInstance()
      .then((pref) => pref.getString(key));
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_id");
    await prefs.remove("email");
    await prefs.remove("full_name");
    await prefs.remove("profile_image");
    await prefs.remove("is_online");
  }

  @override
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
  
  @override
  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  
  @override
  Future<bool?> getBool(String key) async {
    return await SharedPreferences.getInstance().then((pref) => pref.getBool(key));
  }
}