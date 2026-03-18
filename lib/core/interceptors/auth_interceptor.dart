import 'dart:async';

import 'custom_interceptor_contract.dart';
import '../services/session_manager.dart';
import '../../features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor extends CustomInterceptorContact {

  final FlutterSecureStorage flutterSecureStorage;
  final SessionManager sessionManager;
  final IRemoteAuthDataSource remoteAuthDataSource;

  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";

  AuthInterceptor(this.flutterSecureStorage, this.sessionManager, this.remoteAuthDataSource);

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final accessToken = await flutterSecureStorage.read(key: _accessTokenKey);

    if(accessToken == null || accessToken.isEmpty){
      throw Exception("X-Access-Token not found. Request Blocked");
    }

    request.headers["X-ACCESS-TOKEN"] = accessToken;
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({
    required BaseResponse response,
    required Future<BaseResponse> Function() retryRequest}) async{
    // if we get a 401, try to refresh the token
    if(response.statusCode == 401){
      final success = await _tryRefreshToken();
      if(success){
        return await retryRequest();
      }
      else{
        // If failed to refresh the token delete the token from the storage and force the user to logged out
        // Clear flutterSecureStorage
        await flutterSecureStorage.deleteAll();
        // Trigger to redirect to login page
        sessionManager.logout();
      }
    }
    return response;
  }

  Future<bool> _tryRefreshToken() async{
    try{
      
      // Get the refresh token from FlutterSecureStorage
      final refreshToken = await flutterSecureStorage.read(key: _refreshTokenKey);
      if(refreshToken == null) return false;

      // Call the Auth/Refresh token endpoint
      final result = await remoteAuthDataSource.refresh({"refresh_token": refreshToken});
      return await result.fold(
        (failure) async => false,
        (_) async {
          await flutterSecureStorage.write(key: _accessTokenKey, value: "new_access_token");
          return true;
        }
      );      
    }catch(e){
      return false;
    }
  }
}