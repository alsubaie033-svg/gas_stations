import 'package:cloud_firestore/cloud_firestore.dart';
// show DocumentSnapshot, FieldValue, Timestamp;

class MessageModel {
  String senderId;
  String text;
  Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  // Factory constructor for creating a new MessageModel from a Firestore document
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // Convert MessageModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
