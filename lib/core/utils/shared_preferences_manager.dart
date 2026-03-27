
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

  final String userIdKey = "user_id";

  static SharedPreferences? _prefs;

  // Singleton instance
  static final SharedPreferencesManager _instance = SharedPreferencesManager._internal();

  // Factory returns the same instance
  factory SharedPreferencesManager() => _instance;

  SharedPreferencesManager._internal();

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setUserId(String value) async {
    return await _prefs?.setString(userIdKey, value) ?? false;
  }

  String? getUserId() {
    return _prefs?.getString(userIdKey);
  }

  void removeUserId() => _prefs?.remove(userIdKey);

}