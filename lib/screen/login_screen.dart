import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanging/components/button.dart';
import 'package:messanging/components/text_field.dart';
import 'package:messanging/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordControler = TextEditingController();

  void signIn() async{
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
    await authService.signInUserAndPassword(emailController.text, passwordControler.text);
    }
      catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            const Center(
              child: Icon(
                Icons.message,
                size: 80,
              ),
            ),
            // Email and Password

            const Expanded(
                child: SizedBox(
              height: 350,
            )),
            TextFieldWidget(
                textController: emailController,
                hintMessage: "Enter your e-mail",
                obscureText: false),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                textController: passwordControler,
                hintMessage: "Enter your password",
                obscureText: true),

            // Login/Signup button
            const SizedBox(
              height: 20,
            ),

            Button(
                onTap: signIn,
                buttonTitle: "Login"),

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a memeber?"),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
