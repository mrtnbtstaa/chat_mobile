import 'dart:async';

import 'package:chat/core/interceptors/auth_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class InterceptorAdapter implements InterceptorContract{

  final AuthInterceptor _inner;
  final Future<BaseResponse> Function()? retry;

  const InterceptorAdapter(this._inner, {this.retry});

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) async {
    return await _inner.interceptResponse(response: response, retryRequest: retry ?? () => Future.error("retry not implemented"));
  }

  @override
  FutureOr<bool> shouldInterceptRequest() => true;
  @override
  FutureOr<bool> shouldInterceptResponse() => true;
}