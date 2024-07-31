import 'package:flutter/material.dart';
import 'package:g_chat/common/utils.dart';
import 'package:g_chat/constants/app_text_styles.dart';

class ConversationView extends StatelessWidget {
  static const String routeName = "/conversation-view";
  final String recipientFullName;
  final String recipientUserID;
  const ConversationView(
      {super.key,
      required this.recipientFullName,
      required this.recipientUserID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Text(getInitials(recipientFullName)),
            ),
            const SizedBox(width: 10,),
            Text(
              recipientFullName,
              style: AppTextStyles.bodyNormalFont,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(

      ),
    );
  }
}
