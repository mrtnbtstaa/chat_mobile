import 'package:chat/core/errors/failure.dart';

class InvalidEmailFailure extends Failure{
  const InvalidEmailFailure() : super(message: "Invalid email address");

}