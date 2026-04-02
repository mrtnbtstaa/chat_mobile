import 'package:chat/core/contracts/i_local_storage.dart';
import 'package:chat/core/contracts/i_user_storage.dart';

class UserLocalDataSourceImpl implements IUserStorage {

  final ILocalStorage _storage;

  UserLocalDataSourceImpl(this._storage);

  @override
  Future<void> clearUser() async {
    await _storage.clear();
  }

  @override
  Future<String?> getUserInfo(String key) async {
    return await _storage.getString(key);
  }
  
  @override
  Future<void> saveUser(
    String userId,
    String email,
    String fullName,
    String? profileImage,
    bool isOnline
  ) async {
    await _storage.saveString("user_id", userId);
    await _storage.saveString("email", email);
    await _storage.saveString("full_name", fullName);
    await _storage.saveString("profile_image", userId);
    await _storage.saveBool("is_online", isOnline);
  }
  
  @override
  Future<bool?> getUserStatus(String key) async => await _storage.getBool(key);

 
}