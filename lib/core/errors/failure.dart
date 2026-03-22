import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final String message;
  final int statusCode;
  final dynamic error;

  const Failure({required this.message, required this.statusCode, this.error});

  @override
  List<Object?> get props => [message, statusCode, error]; 

  @override
  String toString() => "Failure: $message (Status Code: $statusCode)";

  

}