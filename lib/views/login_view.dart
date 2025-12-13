import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:state_management/views/email_text_field.dart';
import 'package:state_management/views/login_button.dart';
import 'package:state_management/views/password_text_field.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;
  const LoginView({super.key, required this.onLoginTapped});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController= useTextEditingController();
    return Padding(padding: EdgeInsets.all(8),
     child: Column(
       children: [
         EmailTextField(emailController: emailController),
         PasswordTextField(passwordController: passwordController),
         LoginButton(emailController: emailController, passwordController: passwordController, onLoginTapped: onLoginTapped)
       ],
     ),
    );
  }
}
