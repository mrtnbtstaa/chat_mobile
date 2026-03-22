import 'package:chat/core/utils/shared_preferences_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../features/authentication/domain/params/access_token_param.dart';
import '../../features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import '../di/di.dart';
import '../usecases/base_usecase.dart';

enum AuthStatus {authenticated, unauthenticated, unknown}

class SessionManager extends ValueNotifier<AuthStatus> {
  final ILocalAuthDataSource _localAuthDataSource;

  SessionManager(this._localAuthDataSource) : super(AuthStatus.unknown);

  Future<void> initialize() async {

    final token = await _localAuthDataSource.getAccessToken();

    if(token != null && token.isNotEmpty){
        
        // Call the verify token usecase
        final result = await sl<BaseUsecase<Unit, AccessTokenParam>>()(AccessTokenParam(accessToken: token));

        result.fold(
          (failure) {
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
  void logout() {
    SharedPreferencesManager().removeUserId();
    value = AuthStatus.unauthenticated;
  }


}