import 'package:flutter/widgets.dart';

class LoginController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();
  }

}