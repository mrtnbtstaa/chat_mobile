import 'package:chat/core/contracts/i_local_storage.dart';
import 'package:chat/core/contracts/i_user_storage.dart';

class UserLocalDataSourceImpl implements IUserStorage {

  final ILocalStorage _storage;

  UserLocalDataSourceImpl(this._storage);

  final _userIdKey = "user_id";

  @override
  Future<void> clearUserId() async {
    await _storage.remove(_userIdKey);
  }

  @override
  Future<String?> getUserId() async {
    return await _storage.getString(_userIdKey);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await _storage.saveString(_userIdKey, userId);
  }
}