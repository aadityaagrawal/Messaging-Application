import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool condition;
  const ChatBubble({super.key, required this.message, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
      color: condition ? Colors.green[50] : Colors.blue[50],
      borderRadius: BorderRadius.circular(12)

      ),
      child: Text(message, style: const TextStyle(fontSize: 16),),
    );
  }
}