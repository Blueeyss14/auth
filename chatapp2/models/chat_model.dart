
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId, receiverId, text;
  final Timestamp timestamp;

  Message({
    required this.senderId, required this.receiverId, required this.timestamp, required this.text
});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
        senderId: data['senderId'],
        receiverId: data['receiverId'],
        timestamp: data['timestamp'],
        text: data['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'text' : text,
      'timestamp' : timestamp,
    };
  }
}