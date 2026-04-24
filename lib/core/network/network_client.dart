import 'dart:convert';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/core/network/api_response.dart';
import 'package:chat/core/config/app_config.dart';
import 'package:chat/core/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


abstract class NetworkClient {

  String get _baseUrl => AppConfig.instance?.baseUrl ?? "";

  final Client _client;

  NetworkClient({Client? client}) : _client = client ?? Client();

  Future<Either<Failure, T>> _request<T>(
    Future<http.Response> Function() request, 
    {
      required int statusCode,
      required T Function(dynamic) onSuccess
    }
  ) async {
    try{
      final response = await request();
      return _handleResponse(response, onSuccess, statusCode: statusCode);
    }catch(e){
      return left(ServerFailure(message: e.toString(), statusCode: statusCode));
    }
  }

  // POST METHOD
  Future<Either<Failure, T>> post<T>(
    String endpoint,
    {
      required dynamic body,
      required T Function(dynamic) onSuccess,
      final Map<String, String>? headers,
      int statusCode = 200
    }
  ) async {
    return _request<T>(
      onSuccess: onSuccess,
      statusCode: statusCode,
      () async {

        // final url = _uriParser(endpoint);


        // if(body is Map<String, dynamic> && _hasFile(body)){

        //   final request = http.MultipartRequest('PATCH', url);

        //   // Add headers
        //   if(headers != null) request.headers.addAll(headers);

        //   body.forEach((key, value) {
        //     if(value is http.MultipartFile){
        //       request.files.add(value);
        //     }else{
        //       request.fields[key] = value.toString();
        //     }
        //   });

        //   final streamedResponse = await request.send();
        //   return await http.Response.fromStream(streamedResponse);
        // }

        return _client.post(
          _uriParser(endpoint), 
          headers: headers ?? {'Content-Type': 'application/json'},
          body: body is Map ? jsonEncode(body) : body
        );

      }, 
    );
  }

  Future<Either<Failure, T>> get<T>(
    String endpoint,
    {
      final int statusCode = 200,
      final Map<String, String>? headers,
      required T Function(dynamic) onSuccess,
      String? id
    }
  ) async {

    if(id != null && id.isNotEmpty){
      return _request(
        () => _client.get(
          _uriParser("$endpoint$id"), 
          headers: headers ?? {'Content-Type': 'application/json'},
        ), 
        onSuccess: onSuccess,
        statusCode: statusCode
      );
    }

    return _request(
      () => _client.get(
        _uriParser(endpoint), 
        headers: headers ?? {'Content-Type': 'application/json'},
      ), 
      onSuccess: onSuccess,
      statusCode: statusCode
    );

  }

  Future<Either<Failure, T>> put<T>(
    String endpoint,
    {
      required dynamic body,
      final Map<String, String>? headers,
      required T Function(dynamic) onSuccess
    }
  ) async {
    return _request(
      () => _client.put(
        _uriParser(endpoint), 
        headers: headers ?? {'Content-Type': 'application/json'},
        body: body
      ), 
      statusCode: 200,
      onSuccess: onSuccess
    );
  }

  Future<Either<Failure, T>> patch<T>(
    String endpoint,
    {
      dynamic body,
      final Map<String, String>? headers,
      required T Function(dynamic) onSuccess,
      String? imagePath
    }
  ) async {
    return _request(
      () async {

        final url = _uriParser(endpoint);

        if(imagePath != null){

          final request = http.MultipartRequest('PATCH', url);

          // Add fields
          if(body is Map){
            body.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          }

          // Add file
          final file = await http.MultipartFile.fromPath(
            'picture',
            imagePath 
          );
          request.files.add(file);

          // Add headers
          if (headers != null) request.headers.addAll(headers);

          // Use the client with the interceptor
          final client = sl<http.Client>(instanceName: 'interceptedClient');
          // Convert the MultipartRequest to StreamResponse, then to a standard Response
          final streamedResponse = await client.send(request);
          return await http.Response.fromStream(streamedResponse);
        }

        // Handle standard JSON 
        return _client.patch(
          url,
          headers: headers ?? {'Content-Type': 'application/json'},
          body: body is Map ? jsonEncode(body) : body,
        );
 
      }, 
      statusCode: 200,
      onSuccess: onSuccess
    );
  }


  Uri _uriParser(String endpoint){
    // If it's already a full URL, just return the endpoint
    if(endpoint.startsWith('http')){
      return Uri.parse(endpoint);
    }
    // Combined the baseUrl with endpoint
    return Uri.parse("$_baseUrl/$endpoint");
  }

  Future<Either<Failure, T>> _handleResponse<T>(
    http.Response response, 
    T Function(dynamic) onSuccess,
    {
      int statusCode = 200
    }
  ) async {
    try{

      if(kDebugMode){
        print("\x1B[31mResponse Status: ${response.statusCode}");
        Helper.printWrapped(response.body);
      }

      Map<String, dynamic> parseJson(String text){
        return jsonDecode(text) as Map<String, dynamic>;
      }

      // Deserialize the response from the server
      final responseBody = response.body.isEmpty
        ? <String, dynamic>{}
        : await compute(parseJson, response.body);

      // Determine if the server returned a `success` or `error` payload structure
      final apiResponse = handleApiResponse(responseBody);

      if(apiResponse is SuccessResponse && response.statusCode == statusCode){
        // Return the data mapped to onSuccess function
        return right(onSuccess(apiResponse.data));
      }else if(apiResponse is ErrorResponse){
        // Return a server failure which includes the details
        // print("\x1B[31mIssue: ${apiResponse.error.message}\n\x1B[31mField: ${apiResponse.error.details[0].field}, ${apiResponse.error.details[0].issue}");
        return left(
          ServerFailure(
            message: apiResponse.error.message,
            statusCode: response.statusCode,
            error: apiResponse.error.details,
            code: apiResponse.error.code
          )
        );
      }else{
        return left(ServerFailure(
          message: "Unknown server response format",
          statusCode: response.statusCode,
        ));
      }
      

    }catch(e){
      return left(ServerFailure(
        message: e.toString(),
        statusCode: statusCode,
        code: "INTERNAL_SERVER_ERROR"
      ));
    } 
  }

}