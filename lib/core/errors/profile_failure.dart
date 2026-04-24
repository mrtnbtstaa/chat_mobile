import 'package:chat/core/errors/failure.dart';

class ProfileMBFailure extends Failure{
  const ProfileMBFailure(String message) : super(message: message);
}

class ProfileExtensionFailure extends Failure{
  const ProfileExtensionFailure(String message) : super(message: message);
}

class ProfileContentValidationFailure extends Failure{
  const ProfileContentValidationFailure(String message) : super(message: message);
}