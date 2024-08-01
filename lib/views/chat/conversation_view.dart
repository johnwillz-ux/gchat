import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/common/chat_bubble.dart';
import 'package:g_chat/common/utils.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/models/message_model.dart';
import 'package:g_chat/providers/chat_provider.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

/// A widget that displays a conversation view between two users.
///
/// This widget uses the [ChatProvider] to fetch and send messages.

class ConversationView extends StatefulWidget {
  /// The route name for this widget.
  static const String routeName = "/conversation-view";

  /// The full name of the recipient.
  final String recipientFullName;

  /// The user ID of the recipient.
  final String recipientUserID;

  /// Creates a new [ConversationView] instance.
  const ConversationView({
    super.key,
    required this.recipientFullName,
    required this.recipientUserID,
  });

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  /// The text controller for the message input field.
  final TextEditingController _messageController = TextEditingController();

  /// The scroll controller for the message list.
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls the message list to the bottom.
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// The chat provider instance.
    final chatProvider = Provider.of<ChatProvider>(context);

    /// The theme notifier instance.
    final themeData = Provider.of<ThemeNotifier>(context);

    /// The current user's ID.
    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Text(getInitials(widget.recipientFullName)),
            ),
            const SizedBox(width: 10),
            Text(
              widget.recipientFullName,
              style: AppTextStyles.bodyNormalFont,
            ),
          ],
        ),
        backgroundColor: themeData.getTheme() == themeData.lightTheme
            ? Colors.white
            : Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream:
                  chatProvider.getMessages(currentUser, widget.recipientUserID),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const Center(child: CircularProgressIndicator());
                // }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages'));
                }

                var messages = snapshot.data!;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var alignment = message.receiverId != currentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft;

                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: alignment,
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            ChatBubble(
                              color: message.receiverId != currentUser
                                  ? AppColors.kAccentColor
                                  : themeData.getTheme() == themeData.lightTheme
                                      ? Colors.white
                                      : Colors.black,
                              child: Text(message.message),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildSendBtn(chatProvider, context, themeData),
        ],
      ),
    );
  }

  /// Builds the send button.
  ///
  /// This button sends the message when pressed.
  Padding _buildSendBtn(
    ChatProvider chatProvider,
    BuildContext context,
    ThemeNotifier themeData,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: themeData.getTheme() == themeData.lightTheme
            ? Colors.white
            : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 36,
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "Enter your message",
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: AppColors.kBg2Color,
                    filled: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: AppColors.kBg2Color,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                icon: const Icon(
                  IconlyBold.send,
                  size: 18,
                  color: AppColors.kAccentColor,
                ),
                onPressed: () {
                  if (_messageController.text.trim().isEmpty) return;
                  chatProvider.sendMessage(
                    recipientUserId: widget.recipientUserID,
                    message: _messageController.text,
                  );
                  _messageController.clear();
                  _scrollToBottom();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
