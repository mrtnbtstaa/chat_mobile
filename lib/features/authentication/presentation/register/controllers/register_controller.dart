import 'package:flutter/material.dart';

class RegisterController {

  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void dispose(){
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

}