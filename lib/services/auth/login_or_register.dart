import 'package:flutter/material.dart';
import 'package:messanging/screen/login_screen.dart';
import 'package:messanging/screen/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool isLoginPage = true;

    void onSet()
  {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(isLoginPage) {
      return  LoginScreen(onTap: onSet,);
    } else {
      return  RegisterScreen(onTap: onSet);
    }
  }
}