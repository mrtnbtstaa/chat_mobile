import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageManager {

  final String accessTokenKey = "access_token";
  final String refreshTokenKey = "refresh_token";

  static FlutterSecureStorageManager? _instance;

  final FlutterSecureStorage flutterSecureStorage;

  FlutterSecureStorageManager._({required this.flutterSecureStorage});

  static void initialize(FlutterSecureStorage storage){
    _instance ??= FlutterSecureStorageManager._(flutterSecureStorage: storage);
  }

  static FlutterSecureStorageManager? get instance {
    if(_instance == null) throw Exception("FlutterSecureStorageManager is not initialized. call initialize() first.");
    return _instance;
  } 

  Future<String?> getAccessToken() => flutterSecureStorage.read(key: accessTokenKey);
  Future<String?> getRefreshToken() => flutterSecureStorage.read(key: refreshTokenKey);
  Future<void> delete() => flutterSecureStorage.deleteAll();
}