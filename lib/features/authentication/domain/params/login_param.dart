

import 'package:chat/features/authentication/domain/value_objects/email.dart';

class LoginParam{
  final Email email;
  final String password;
  
  const LoginParam({
    required this.email,
    required this.password
  });
  
}