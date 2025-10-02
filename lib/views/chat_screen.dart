import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../models/message_model.dart';

// --- COLOR DEFINITIONS (Based on Android XML colors) ---
const Color kOrange = Color(0xFFFF9800);
const Color kBlueSent = Color(0xFF007AFF);
const Color kGreenReceived = Color(0xFFE6F0E6);
const Color kWhite = Color(0xFFFFFFFF);
const Color kLightGray = Color(0xFFCCCCCC);
const Color kDarkGray = Color(0xFF666666);

// --- CUSTOM WIDGETS ---

// Widget for a received message bubble
class ReceivedMessageBubble extends StatelessWidget {
  final MessageModel message;
  const ReceivedMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 60.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: const CircleAvatar(
                backgroundColor: kLightGray,
                radius: 16,
                child: Icon(Icons.person, color: kDarkGray, size: 20),
              ),
            ),
            // Message Content
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: kGreenReceived,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for a sent message bubble
class SentMessageBubble extends StatelessWidget {
  final MessageModel message;
  const SentMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 60.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: kBlueSent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
          ),
          child: Text(
            message.text,
            style: const TextStyle(color: kWhite, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// --- MAIN CHAT SCREEN WIDGET ---

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the ChatController using Get.put()
    final controller = Get.put(ChatController());

    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(context),
          // Message List (Obx reacts to changes in controller.messages)
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: false, // Display messages from top to bottom
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  if (controller.isSentByMe(message)) {
                    return SentMessageBubble(message: message);
                  } else {
                    return ReceivedMessageBubble(message: message);
                  }
                },
              ),
            ),
          ),
          _buildInputArea(controller),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // --- UI PARTIALS ---

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: kOrange,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: kWhite, size: 24),
          ),
          const SizedBox(width: 16.0),
          // Title/Subtitle
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'First aid assistance',
                style: TextStyle(color: kWhite, fontSize: 14),
              ),
              Text(
                'Conversation with your Chatbot',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(ChatController controller) {
    return Container(
      color: kOrange,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: kLightGray, width: 1.0),
              ),
              child: TextField(
                controller: controller.textController,
                decoration: const InputDecoration(
                  hintText: 'Write your text...',
                  hintStyle: TextStyle(color: kLightGray),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Voice Input Icon
          const Icon(Icons.mic, color: Colors.black, size: 28),
          const SizedBox(width: 8.0),
          // Send Button
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: kWhite.withOpacity(
                  0.0,
                ), // Invisible background for mic/send buttons
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: kWhite, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    // This is a simplified representation of the BottomNavigationBar
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kOrange,
      unselectedItemColor: kDarkGray,
      backgroundColor: kWhite,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        // Handle navigation taps
      },
    );
  }
}
