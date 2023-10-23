import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;
  final String message;

  Message(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.timestamp,
      required this.message});

  // Converting it to map
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "timestamp": timestamp,
      "message": message
    };
    return data;
  }

  // Converting from Json
  static Message fromJson(Map<String, dynamic> data) {
    return Message(
        senderId: data["senderId"],
        senderEmail: data['senderEmail'],
        receiverId: data['receiverId'],
        timestamp: data['timestamp'],
        message: data['message']);
  }
}
