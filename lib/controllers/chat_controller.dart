import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  // Observable list of messages
  final messages = <MessageModel>[].obs;

  // Hardcoded for demonstration, replace with actual user data from authentication
  final String currentUserId = 'user1';
  final String otherUserId = 'user2';

  late final String _chatRoomId;
  late final CollectionReference<Map<String, dynamic>> _messagesCollection;

  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Determine the chat room ID
    _chatRoomId = _getChatRoomId(currentUserId, otherUserId);

    // Set up the Firestore path
    _messagesCollection = FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatRoomId)
        .collection('messages');

    // Start listening for messages
    listenForMessages();
  }

  // Generates a consistent chat room ID by sorting user IDs
  String _getChatRoomId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  // Real-time listener for new messages
  void listenForMessages() {
    _messagesCollection
        .orderBy('timestamp', descending: true) // Order by timestamp
        .limit(50) // Limit to last 50 messages
        .snapshots()
        .listen((snapshot) {
          final newMessages = snapshot.docs
              .map(MessageModel.fromFirestore)
              .toList();

          // Since we fetch in descending order, reverse it for display
          messages.value = newMessages.reversed.toList();
        });
  }

  // Sends a message to Firestore
  void sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final newMessage = MessageModel(
      senderId: currentUserId,
      text: text,
      timestamp: Timestamp.now(),
    );

    try {
      // Use the toMap method which includes FieldValue.serverTimestamp()
      await _messagesCollection.add(newMessage.toMap());
      textController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Determines if the message was sent by the current user
  bool isSentByMe(MessageModel message) {
    return message.senderId == currentUserId;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
