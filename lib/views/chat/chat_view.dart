import 'package:flutter/material.dart';
import 'package:g_chat/common/utils.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/providers/user_provider.dart';
import 'package:g_chat/views/chat/conversation_view.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "/chat-view";
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: AppTextStyles.headingMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text(getInitials(user.fullName)),
                      ),
                      title: Text(user.fullName),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConversationView(
                                      recipientFullName: user.fullName,
                                      recipientUserID: user.uid,
                                    )));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
