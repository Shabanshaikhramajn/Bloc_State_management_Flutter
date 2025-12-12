import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/strings.dart' show enterYourEmailHere;

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
   EmailTextField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: emailController,
       keyboardType: TextInputType.emailAddress,
       autocorrect: false,
       decoration:  InputDecoration(
         hintText: enterYourEmailHere)
    );
  }
}
