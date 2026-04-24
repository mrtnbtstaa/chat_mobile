import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../features/authentication/domain/params/access_token_param.dart';
import '../di/di.dart';
import '../usecases/base_usecase.dart';

enum AuthStatus {authenticated, unauthenticated, unknown}

class SessionManager extends ValueNotifier<AuthStatus> {

  final ITokenStorage _tokenStorage;
  final IUserStorage _userStorage;

  SessionManager(this._tokenStorage, this._userStorage) : super(AuthStatus.unknown);

  Future<void> initialize() async {

    final token = await _tokenStorage.getAccessToken();

    if(token != null && token.isNotEmpty){
        
        // Call the verify token usecase
        final result = await sl<BaseUsecase<Unit, AccessTokenParam>>()(AccessTokenParam(accessToken: token));

        result.fold(
          (failure) async {
            logout();
          },
          (_) {
            value = AuthStatus.authenticated;
          }
        );

    }else{
      value = AuthStatus.unauthenticated;
    }
    if(kDebugMode){
      print("Current auth status: $value");
    }

  }

  void login() => value = AuthStatus.authenticated;
  Future<void> logout() async {
    if(kDebugMode){
      print("Logout method triggered!");
    }
    await _userStorage.clearUser();
    await _tokenStorage.clearTokens();
    value = AuthStatus.unauthenticated;
  }


}