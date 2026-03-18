import 'package:flutter/widgets.dart';

class LoginController {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
  }

}