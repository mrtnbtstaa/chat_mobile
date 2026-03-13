import 'package:flutter/material.dart';

class RegisterController {

  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void dispose(){
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

}