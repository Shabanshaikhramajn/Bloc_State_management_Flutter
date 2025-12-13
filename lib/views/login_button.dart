import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/dialogs/generic_dialog.dart';
import 'package:state_management/strings.dart';

typedef OnLoginTapped =  void Function(
    String email,
    String password
    );


class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;
  const LoginButton({super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
       final email = emailController.text;
       final password = passwordController.text;
       if(email.isEmpty || password.isEmpty ){
         showGenericDialog(context: context,
             title: emailOrPasswordDescription ,
             content: emailOrPasswordDescription,
             optionsBuilder: ()=> {ok: true}
         );
       } else {
         onLoginTapped(
           email, password
         );
       }
    }
        , child: Text("Login"));
  }
}
