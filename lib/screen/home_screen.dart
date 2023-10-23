import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanging/screen/chat_screen.dart';
import 'package:messanging/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOutMethod() {
    final _authService = Provider.of<AuthService>(context, listen: false);
    _authService.signOut();
  }

  final _authUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: signOutMethod, icon: const Icon(Icons.logout))
        ],
      ),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error loading users");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((e) => buildWidgetItem(e))
                .toList(),
          );
        });
  }

  Widget buildWidgetItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;

    if (_authUser.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatPage(
                    title: data['email'],
                    receiverUserId: data['uid'],
                  )));
        },
      );
    } else {
      return Container();
    }
  }
}
