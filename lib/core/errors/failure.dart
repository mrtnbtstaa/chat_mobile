import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final String message;
  final int statusCode;
  final dynamic error;
  final String? code;

  const Failure({required this.message, required this.statusCode, this.error, this.code});

  @override
  List<Object?> get props => [message, statusCode, error, code]; 

  @override
  String toString() => "Failure: $message (Status Code: $statusCode)";

  

}