import 'package:flutter/material.dart';

class RegisterController {

  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void dispose(){
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

}