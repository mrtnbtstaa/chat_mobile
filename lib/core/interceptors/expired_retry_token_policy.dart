import 'dart:async';

import 'package:chat/core/interceptors/auth_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ExpiredRetryTokenPolicy extends RetryPolicy{
  
  final AuthInterceptor _authInterceptor;

  ExpiredRetryTokenPolicy(this._authInterceptor);

  @override
  int get maxRetryAttempts => 1;

  @override
  FutureOr<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if(response.statusCode == 401){
      final success = await _authInterceptor.tryRefreshToken();
      return success;
    }
    return false;
  }

}