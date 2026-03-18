import 'package:chat/features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import 'package:chat/features/authentication/infrastructure/dtos/token_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements ILocalAuthDataSource{

  final FlutterSecureStorage flutterSecureStorage;

  const AuthLocalDataSourceImpl({required this.flutterSecureStorage});
  
  static const String _accessKey = "access_token";
  static const String _refreshKey = "refresh_token";

  @override
  Future<void> clearAll() {
    return flutterSecureStorage.deleteAll();
  }
  
  @override
  Future<String?> getAccessToken() {
    return flutterSecureStorage.read(key: _accessKey);
  }
  
  @override
  Future<String?> getRefreshToken() {
    return flutterSecureStorage.read(key: _refreshKey);
  }
  
  @override
  Future<TokenDto> cacheToken(String accessToken, String refreshToken) async {
    await flutterSecureStorage.write(key: _accessKey, value: accessToken);
    await flutterSecureStorage.write(key: _refreshKey, value: refreshToken);
    return TokenDto(accessToken: accessToken, refreshToken: refreshToken);
  }

 
}