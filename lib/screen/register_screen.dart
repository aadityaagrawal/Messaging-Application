import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanging/components/button.dart';
import 'package:messanging/components/text_field.dart';
import 'package:messanging/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final emailController = TextEditingController();
  final passwordControler = TextEditingController();
  final repasswordControler = TextEditingController();


  void registerUserWithEmailAndPassword()  async
  {
    
    if(passwordControler.text != repasswordControler.text)
    {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Different Password")));
    }
    else{
      final _authService = Provider.of<AuthService>(context, listen: false);
      try{
        UserCredential userCredential = await _authService.signUpUserAndPassword(emailController.text, passwordControler.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User created successfully")));
      }
      catch(e)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Logo
          const Center(child: Icon(Icons.message, size: 80,),),
          // Email and Password

          const Expanded(child:  SizedBox(height: 350,)),
          TextFieldWidget(textController: emailController, hintMessage: "Enter your e-mail", obscureText: false),
          const SizedBox(height: 20,),
          TextFieldWidget(textController: passwordControler, hintMessage: "Enter your password", obscureText: true),
          const SizedBox(height: 20,),
          TextFieldWidget(textController: repasswordControler, hintMessage: "Re-Enter your password", obscureText: true),

            // Login/Signup button
          const SizedBox(height: 20,),
            
          Button(onTap: registerUserWithEmailAndPassword, buttonTitle: "Sign Up"),

          const SizedBox(height: 20,),

           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Already a memeber?"),
            const SizedBox(width: 4,),
            GestureDetector(
              onTap: widget.onTap,
              child: const Text("Login Now", style: TextStyle(fontWeight: FontWeight.bold),))
          ],)

          ],
        ),
      )
      ),
    );
  }
}