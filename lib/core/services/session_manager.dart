import 'package:chat/features/authentication/domain/params/access_token_param.dart';

import '../di/di.dart';
import '../usecases/base_usecase.dart';
import '../../features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum AuthStatus {authenticated, unauthenticated, unknown}

class SessionManager extends ValueNotifier<AuthStatus> {
  final ILocalAuthDataSource _localAuthDataSource;

  SessionManager(this._localAuthDataSource) : super(AuthStatus.unknown);

  Future<void> initialize() async {

    final token = await _localAuthDataSource.getAccessToken();

    if(token != null && token.isNotEmpty){
      try{
        
        // Call the verify token usecase
        await sl<BaseUsecase<Unit, AccessTokenParam>>()(AccessTokenParam(accessToken: token));
        value = AuthStatus.authenticated;
      }catch(e){
        await _localAuthDataSource.clearTokens();
        logout();
      }

    }else{
      value = AuthStatus.unauthenticated;
    }
    if(kDebugMode){
      print("Current auth status: $value");
    }

  }

  void login() => value = AuthStatus.authenticated;
  void logout() async {
    await _localAuthDataSource.clearTokens();
    value = AuthStatus.unauthenticated;
  }
}