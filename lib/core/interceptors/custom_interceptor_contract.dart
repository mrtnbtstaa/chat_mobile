import 'dart:async';

import 'package:http/http.dart';

abstract class CustomInterceptorContact{
  FutureOr<BaseRequest> interceptRequest({
    required BaseRequest request,
  });

  FutureOr<BaseResponse> interceptResponse({
    required BaseResponse response,
    required Future<BaseResponse> Function() retryRequest
  });

}