import 'package:chat/core/errors/failure.dart';

final class ServerFailure extends Failure{
  const ServerFailure({required super.message, required super.statusCode});

  @override
  String toString() => "ServerFailure: $message (Status Code: $statusCode)";

}