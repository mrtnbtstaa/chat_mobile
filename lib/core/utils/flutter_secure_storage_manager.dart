import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageManager {

  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";

  static FlutterSecureStorageManager? _instance;

  final FlutterSecureStorage flutterSecureStorage;

  FlutterSecureStorageManager._({required this.flutterSecureStorage});

  static void initialize(FlutterSecureStorage storage){
    _instance ??= FlutterSecureStorageManager._(flutterSecureStorage: storage);
  }

  static FlutterSecureStorageManager? get instance {
    if(_instance == null) throw Exception("FlutterSecureStorageManager is not initialized. Call initialize() first.");
    return _instance;
  } 

  Future<String?> getAccessToken() async => await flutterSecureStorage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() async => await flutterSecureStorage.read(key: _refreshTokenKey);
  Future<void> delete() => flutterSecureStorage.deleteAll();
}