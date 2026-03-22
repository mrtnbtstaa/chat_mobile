import 'dart:async';

import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../features/authentication/domain/entities/token_entity.dart';
import '../../features/authentication/domain/params/refresh_token_param.dart';
import '../constants/api_constant.dart';
import '../di/di.dart';
import '../services/session_manager.dart';
import '../usecases/base_usecase.dart';

class AuthInterceptor extends InterceptorContract {

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  final FlutterSecureStorage flutterSecureStorage;
  final SessionManager sessionManager;

  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";

  AuthInterceptor(this.flutterSecureStorage, this.sessionManager);

  bool _isWhiteListed(String path){
    final List<String> whitelist = [
      ApiConstant.loginApi, 
      ApiConstant.registerApi, 
      ApiConstant.refreshApi, 
    ];

    return whitelist.any((pattern) => path.contains(pattern));
  }

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {

    // To avoid adding headers to the whitelisted
    if(_isWhiteListed(request.url.path)) return request;

    if(_isRefreshing){
      print("Request for ${request.url.path} is waiting for token refresh...");
      await _refreshCompleter?.future;
    }

    // Get the access token from the flutterSecureStorage
    final accessToken = await flutterSecureStorage.read(key: _accessTokenKey);

    // Check if the token is not null or not empty
    if(accessToken != null && accessToken.isNotEmpty){
      request.headers.update(
        "Authorization", 
        (value) => "Bearer $accessToken",
        ifAbsent: () => "Bearer $accessToken"
      );
        // request.headers["Authorization"] = "Bearer $accessToken";
    }


    // Force overwrite headers
    // request.headers.update(
    //   "Authorization", 
    //   (value) => "Bearer $accessToken",
    //   ifAbsent: () => "Bearer $accessToken"
    // );
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) async => response;

  Future<bool> tryRefreshToken() async{

    if(kDebugMode){
      print("Running try refresh token!");
    }
    // If a refresh is already in progress.
    if(_isRefreshing){
      return _refreshCompleter?.future ?? Future.value(false);
    }


    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try{

    // Get the refresh token from FlutterSecureStorage
    final refreshToken = await flutterSecureStorage.read(key: _refreshTokenKey);

    if(refreshToken == null){
      _handleLogout();
      _refreshCompleter?.complete(false);
      return false;
    }

    // Call the Refresh token usecase
    final result = await sl<BaseUsecase<TokenEntity, RefreshTokenParam>>()(RefreshTokenParam(refreshToken: refreshToken));

    final success = await result.fold(
      (failure) async {
        _handleLogout();
        _refreshCompleter?.complete(false);
        return false;
      },
      (entity) async {
        if(kDebugMode){
          print("Saving the new access ${entity.accessToken} and refresh token ${entity.refreshToken}");
        }
        await flutterSecureStorage.write(key: _accessTokenKey, value: entity.accessToken);
        await flutterSecureStorage.write(key: _refreshTokenKey, value: entity.refreshToken);
        await Future.delayed(200.milliseconds());
        _refreshCompleter?.complete(true);
        return true;
      }
    ); 

    return success;

    }catch (e){
      _handleLogout();
      if(_refreshCompleter?.isCompleted == false){
        _refreshCompleter?.complete(false);
      }
      return false;
    }finally{
      Future.delayed(100.milliseconds(), (){
        _isRefreshing = false;
        _refreshCompleter = null;
      });
    }

  }


  void _handleLogout(){
    flutterSecureStorage.deleteAll();
    sessionManager.logout();
  }
}