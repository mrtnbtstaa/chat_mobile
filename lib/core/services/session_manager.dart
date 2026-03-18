import 'package:chat/features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus {authenticated, unauthenticated, unknown}

class SessionManager extends ValueNotifier<AuthStatus> {
  final ILocalAuthDataSource _localAuthDataSource;
  SessionManager(this._localAuthDataSource) : super(AuthStatus.unknown);

  Future<void> initialize() async {
    final token = await _localAuthDataSource.getAccessToken();

    if(token != null && token.isNotEmpty){
      value = AuthStatus.authenticated;
    }else{
      value = AuthStatus.unauthenticated;
    }

  }

  void login() => value = AuthStatus.authenticated;
  void logout() => value = AuthStatus.unauthenticated;
}