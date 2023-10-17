import 'package:flutter/material.dart';
import 'package:messanging/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void signOutMethod(){
    final _authService = Provider.of<AuthService>(context, listen: false);
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),

        actions: [
          IconButton(onPressed: signOutMethod, icon: const Icon(Icons.logout))
        ],
      ),

    );
  }
}