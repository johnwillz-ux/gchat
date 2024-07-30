import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_text_styles.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "/chat-view";
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: AppTextStyles.headingMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
