import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements ITokenStorage {

  final FlutterSecureStorage _flutterSecureStorage;

  const AuthLocalDataSourceImpl(this._flutterSecureStorage);
  
  static const String _accessKey = "access_token";
  static const String _refreshKey = "refresh_token";

  @override
  Future<void> clearTokens() async {
    return await _flutterSecureStorage.deleteAll();
  }
  
  @override
  Future<String?> getAccessToken() {
    return _flutterSecureStorage.read(key: _accessKey);
  }
  
  @override
  Future<String?> getRefreshToken() {
    return _flutterSecureStorage.read(key: _refreshKey);
  }
  
  @override
  Future<void> cacheToken(String accessToken, String refreshToken) async {
    await _flutterSecureStorage.write(key: _accessKey, value: accessToken);
    await _flutterSecureStorage.write(key: _refreshKey, value: refreshToken);
  }

 
}