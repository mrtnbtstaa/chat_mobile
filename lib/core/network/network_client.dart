import 'dart:convert';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/core/network/api_response.dart';
import 'package:chat/core/resources/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


abstract class NetworkClient {

  String get _baseUrl => AppConfig.instance?.baseUrl ?? "";

  final Client _client;

  NetworkClient({Client? client}) : _client = client ?? Client();

  Future<Either<Failure, T>> _request<T>(
    Future<http.Response> Function() request, {
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
      () => _client.post(
        _uriParser(endpoint), 
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body)
      ), 
      onSuccess: onSuccess,
      statusCode: statusCode
    );
  }

  Future<Either<Failure, T>> multipart<T>(
    String endpoint,
    {
      required dynamic body,
      required T Function(dynamic) onSuccess,
      final Map<String, String>? headers,
      String? imagePath
    }
  ) async {
    
    final request = http.MultipartRequest("POST", _uriParser(endpoint));

    if(body != null && body is Map<String, dynamic>){
      body.forEach((key, value) {
        if(value == null) return;
        if(value is String) {request.fields[key] = value;}
        else if(value is http.MultipartFile) {request.files.add(value);}
      });
    }else{return Left(ServerFailure(message: "Body cannot be null or empty", statusCode: 400));}

    // Add the imagePath to the requests if provided
    if(imagePath != null && imagePath.isNotEmpty){
      try{
        final file = http.MultipartFile.fromString('profile_image', imagePath);
        request.files.add(file);
      }catch(e){
        return Left(ServerFailure(message: "Could not processed image", statusCode: 500));
      }
    }

    final response = await request.send();

    final responseString = await response.stream.bytesToString();

    final httpResponse = http.Response(responseString, response.statusCode, headers: headers ?? {'Format': 'multipart/form-data'});

    return _handleResponse(httpResponse, onSuccess, statusCode: 201);

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

  // Future<Either<Failure, Map<String, dynamic>>> put(
  //   String endpoint,
  //   {
  //     required dynamic body,
  //     final Map<String, String>? headers
  //   }
  // ) async {
  //   return _request(
  //     () => http.put(
  //       _uriParser(endpoint), 
  //       headers: headers ?? {'Content-Type': 'application/json'},
  //       body: body
  //     ), 
  //     statusCode: 200
  //   );
  // }

  // Future<Either<Failure, Map<String, dynamic>>> patch(
  //   String endpoint,
  //   {
  //     required dynamic body,
  //     final Map<String, String>? headers
  //   }
  // ) async {
  //   return _request(
  //     () => http.patch(
  //       _uriParser(endpoint), 
  //       headers: headers ?? {'Content-Type': 'application/json'},
  //       body: body
  //     ), 
  //     statusCode: 200
  //   );
  // }



  Uri _uriParser(String endpoint){
    // If it's already a full URL, just return the endpoint
    if(endpoint.startsWith('http')){
      return Uri.parse(endpoint);
    }
    // Combined the baseUrl with endpoint
    return Uri.parse("$_baseUrl/$endpoint");
  }

  Either<Failure, T> _handleResponse<T>(
    http.Response response, 
    T Function(dynamic) onSuccess,
    {
      int statusCode = 200
    }
  ){
    try{


      if(kDebugMode){
        print("\x1B[31mResponse Status: ${response.statusCode}");
        print("\x1B[31mResponse Status: ${response.body}");
      }

      // Deserialize the response from the server
      final responseBody = response.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(response.body);


      // if(kDebugMode){
      //   print("\x1B[31mResponse Body: $responseBody");
      // }


      // Determine if the server returned a `success` or `error` payload structure
      final apiResponse = handleApiResponse(responseBody);

      if(apiResponse is SuccessResponse && response.statusCode == statusCode){
        // Return the data mapped to onSuccess function
        return right(onSuccess(apiResponse.data));
      }else if(apiResponse is ErrorResponse){
        // Return a server failure which includes the details
        print("\x1B[31mIssue: ${apiResponse.error.message}\n\x1B[31mField: ${apiResponse.error.details[0].field}, ${apiResponse.error.details[0].issue}");
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
      if(kDebugMode){
        print("Server Failure: $e");
      }
      return left(ServerFailure(
        message: e.toString(),
        statusCode: statusCode,
        code: "INTERNAL_SERVER_ERROR"
      ));
    }
  }

}