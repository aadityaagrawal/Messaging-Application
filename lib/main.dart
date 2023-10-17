import 'package:flutter/material.dart';
import 'package:messanging/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messanging/services/auth/auth_gate.dart';
import 'package:messanging/services/auth/auth_service.dart';
import 'package:messanging/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
    create: (context)=> AuthService(),
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}