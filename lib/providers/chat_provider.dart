import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_chat/models/message_model.dart';
import 'package:g_chat/repositories/chat_repository.dart';

/// A provider class for managing chat functionality.
///
/// This class provides methods for fetching messages and sending new messages.
class ChatProvider with ChangeNotifier {
  /// The repository for chat-related data operations.
  final ChatRepository chatRepository;

  /// Initializes a new instance of [ChatProvider].
  ///
  /// [chatRepository] is required and must not be null.
  ChatProvider({required this.chatRepository});

  /// Fetches a stream of messages for a conversation between two users.
  ///
  /// [userId] is the ID of the current user.
  /// [otherUserId] is the ID of the other user in the conversation.
  ///
  /// Returns a stream of [MessageModel] objects representing the messages in the conversation.

  Stream<List<MessageModel>> getMessages(String userId, String otherUserId) {
    log("Fetching messages for chat between $userId and $otherUserId");
    return chatRepository.getMessages(userId, otherUserId);
  }

  /// Sends a new message to a recipient user.
  ///
  /// [recipientUserId] is the ID of the user receiving the message.
  /// [message] is the content of the message to be sent.
  ///
  /// Returns a future that completes when the message has been sent.

  Future<void> sendMessage({
    required String recipientUserId,
    required String message,
  }) async {
    await chatRepository.sendMessage(
      recipientUserId: recipientUserId,
      message: message,
    );
    notifyListeners();
  }
}