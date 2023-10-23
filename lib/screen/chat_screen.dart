import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messanging/components/chat_bubble.dart';
import 'package:messanging/components/text_field.dart';
import 'package:messanging/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String receiverUserId;

  const ChatPage(
      {super.key, required this.title, required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text(
          widget.title,
          
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ]),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: chatService.getMessage(
            auth.currentUser!.uid, widget.receiverUserId),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children:
                snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'],
            condition: data['senderId'] == auth.currentUser!.uid,
          ),
          Text(data['senderEmail'], style: TextStyle(fontSize: 12, color: Colors.grey),),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: TextFieldWidget(
                textController: _messageController,
                hintMessage: "Type Message...",
                obscureText: false)),
        IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
