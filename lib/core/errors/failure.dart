import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final String? message;
  final int? statusCode;
  final dynamic error;
  final String? code;

  const Failure({this.message, this.statusCode, this.error, this.code});

  @override
  List<Object?> get props => [message, statusCode, error, code]; 

  @override
  String toString() => "Failure: $message (Status Code: $statusCode)";
}

