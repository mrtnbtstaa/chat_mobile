import 'dart:convert';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/errors/server_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;


abstract class NetworkClient {

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

  // Future<Either<Failure, T>> get<T>(
  //   String endpoint,
  //   {
  //     final Map<String, String>? headers,
  //     required int id
  //   }
  // ) async {
  //   return _request(
  //     () => http.get(
  //       _uriParser("$endpoint/$id"), 
  //       headers: headers ?? {'Content-Type': 'application/json'},
  //     ), 
  //     statusCode: 200
  //   );
  // }

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



  Uri _uriParser(String endpoint) => Uri.parse("http://test.com/login");

  Either<Failure, T> _handleResponse<T>(
    http.Response response, 
    T Function(dynamic) onSuccess,
    {
      int statusCode = 200
    }
  ){
    try{

      // Deserialize the response from the server
      final responseBody = response.body.isEmpty
        ? <String, dynamic>{}
        : jsonDecode(response.body);

      if(response.statusCode == statusCode){ 
        return right(onSuccess(responseBody));
      }else{
        final message = (responseBody is Map) ? responseBody["message"] : "Server error";
        return left(ServerFailure(
          message: message ?? "Unknown error",
          statusCode: response.statusCode
        ));
      }

    }catch(e){
      return left(ServerFailure(
        message: e.toString(),
        statusCode: statusCode
      ));
    }
  }

}