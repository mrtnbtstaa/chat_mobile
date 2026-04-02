import 'dart:async';

import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../features/authentication/domain/entities/token_entity.dart';
import '../../features/authentication/domain/params/refresh_token_param.dart';
// import '../constants/api_constant.dart';
import '../di/di.dart';
import '../extensions/int_extension.dart';
import '../services/session_manager.dart';
import '../usecases/base_usecase.dart';

class AuthInterceptor extends InterceptorContract {

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  final ITokenStorage tokenStorage;
  final SessionManager sessionManager;


  AuthInterceptor(this.tokenStorage, this.sessionManager);

  // bool _isWhiteListed(String path){
  //   final List<String> whitelist = [
  //     ApiConstant.loginApi, 
  //     ApiConstant.registerApi, 
  //     ApiConstant.refreshApi, 
  //   ];

  //   return whitelist.any((pattern) => path.contains(pattern));
  // }

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {


    // To avoid adding headers to the whitelisted
    // if(_isWhiteListed(request.url.path)) return request;

    if(_isRefreshing){
      await _refreshCompleter?.future;
    }

    // Get the access token from the flutterSecureStorage
    final accessToken = await tokenStorage.getAccessToken();

    // Check if the token is not null or not empty
    if(accessToken != null && accessToken.isNotEmpty){
      request.headers.update(
        "Authorization", 
        (value) => "Bearer $accessToken",
        ifAbsent: () => "Bearer $accessToken"
      );
    }

  // print("ACCESS TOKEN: $accessToken");
  // print("REQUEST: ${request.url}");
  // print("HEADERS: ${request.headers}");

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
    final refreshToken = await tokenStorage.getRefreshToken();

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
        await tokenStorage.cacheToken(entity.accessToken, entity.refreshToken);
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


  Future<void> _handleLogout() async {
    await tokenStorage.clearTokens();
    sessionManager.logout();
  }
}