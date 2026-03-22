import 'dart:convert';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/core/network/api_response.dart';
import 'package:chat/core/resources/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;


abstract class NetworkClient {

  String get _baseUrl => AppConfig.instance?.baseUrl ?? "";

  final http.Client _client;

  NetworkClient({http.Client? client}) : _client = client ?? http.Client();

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
        return Left(ServerFailure(message: "Could not processed image", statusCode: 400));
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
      required int id
    }
  ) async {
    return _request(
      () => http.get(
        _uriParser("$endpoint/$id"), 
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



  Uri _uriParser(String endpoint) => Uri.parse("$_baseUrl/$endpoint");

  Either<Failure, T> _handleResponse<T>(
    http.Response response, 
    T Function(dynamic) onSuccess,
    {
      int statusCode = 200
    }
  ){
    try{


      if(kDebugMode){
        print("Response Status: ${response.statusCode}");
        print("Response Status: ${response.body}");
      }

      // Deserialize the response from the server
      final responseBody = response.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(response.body);


      // Determine if the server returned a `success` or `error` payload structure
      final apiResponse = handleApiResponse(responseBody);

      if(apiResponse is SuccessResponse && response.statusCode == statusCode){
        // Return the data mapped to onSuccess function
        return right(onSuccess(apiResponse.data));
      }else if(apiResponse is ErrorResponse){
        // Return a server failure which includes the details
        print("Error: ${apiResponse.error.message}, ${apiResponse.error.details[0].field}");
        return left(
          ServerFailure(
            message: apiResponse.error.message,
            statusCode: response.statusCode,
            error: apiResponse.error.details
          )
        );
      }else{
        return left(ServerFailure(
          message: "Unknown server response format",
          statusCode: response.statusCode,
        ));
      }
      

    }catch(e){
      print("!!!!Server failure: $e");
      return left(ServerFailure(
        message: e.toString(),
        statusCode: statusCode
      ));
    }
  }

}