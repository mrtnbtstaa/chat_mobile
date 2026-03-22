import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  
  final String userIdKey = "user_id";

  final SharedPreferences sharedPreferences;

  const SharedPreferencesManager._({required this.sharedPreferences});

  static SharedPreferencesManager? _instance;


  static void initialize(SharedPreferences sharedPreference)  {
    _instance ??= SharedPreferencesManager._(sharedPreferences: sharedPreference);
  }

  static SharedPreferencesManager? get instance {
    if(_instance == null) throw Exception("SharedPreferencesManager is not initialized. Call initialize first");
    return _instance;
  }

  Future<void> setString(String value) async {
    await sharedPreferences.setString(userIdKey, value);
  }

  String getString(String key) {
    return sharedPreferences.getString(key) ?? "";
  }

  void remove(String key){
    sharedPreferences.remove(key);
  }

}