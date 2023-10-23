import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messanging/model/chat_model.dart';

class ChatService {
  final auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    String currentUserId = auth.currentUser!.uid;
    String currentUserMail = auth.currentUser!.email.toString();
    Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserMail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    List<String> ids = [receiverId, currentUserId];
    ids.sort();

    String chatId = ids.join("_");

    await store
        .collection("chat-room")
        .doc(chatId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  //get message

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> chatIds = [userId, otherUserId];
    chatIds.sort();
    String chatId = chatIds.join("_");

    return store
        .collection('chat-room')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
