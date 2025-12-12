import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/strings.dart' show enterYourPasswordHere;

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: passwordController,
        obscureText: true,
        obscuringCharacter: '*',
        autocorrect: false,
        decoration:  InputDecoration(
            hintText: enterYourPasswordHere)
    );
  }
}
