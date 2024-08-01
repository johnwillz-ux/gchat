import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:g_chat/common/snak_bar_notification.dart';
import 'package:g_chat/models/message_model.dart';
import 'package:g_chat/models/user_model.dart';

/// A repository for managing chat functionality.
///
/// This class provides methods for fetching users, sending messages, and retrieving messages.
class ChatRepository extends ChangeNotifier {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  /// Creates a new instance of [ChatRepository].
  ///
  /// [auth] and [fireStore] are required.
  ChatRepository({required this.auth, required this.fireStore});

  /// Fetches a list of users from the Firestore database.
  ///
  /// The list of users does not include the current user.
  ///
  /// Returns a [Future] that completes with a list of [UserModel] objects.
  ///
  /// Example:
  /// ```dart
  /// final chatRepository = ChatRepository(auth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
  /// final users = await chatRepository.fetchUsers('currentUserId');
  /// ```
  Future<List<UserModel>> fetchUsers(String currentUserUid) async {
    try {
      var usersSnapshot = await fireStore.collection('users').get();

      var userList = usersSnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .where((user) => user.uid != currentUserUid)
          .toList();

      return userList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  /// Sends a message to a recipient user.
  ///
  /// [recipientUserId] is the ID of the user to send the message to.
  /// [message] is the text of the message to send.
  ///
  /// Returns a [Future] that completes when the message has been sent.
  ///
  /// Example:
  /// ```dart
  /// final chatRepository = ChatRepository(auth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
  /// await chatRepository.sendMessage(recipientUserId: 'recipientUserId', message: 'Hello!');
  /// ```
  Future<void> sendMessage({
    required String recipientUserId,
    required String message,
  }) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: recipientUserId,
      message: message,
      timestamp: timestamp,
    );

    try {
      List<String> ids = [currentUserId, recipientUserId];

      ids.sort();
      String chatRoomId = ids.join("&");

      await fireStore
          .collection("chat-rooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(
            newMessage.toMap(),
          );

      log('Message sent to $recipientUserId');
    } catch (e) {
      log(e.toString());
    }
  }

  /// Retrieves a stream of messages between the current user and another user.
  ///
  /// [userId] is the ID of the current user.
  /// [otherUserId] is the ID of the other user.
  ///
  /// Returns a [Stream] of [MessageModel] objects.
  ///
  /// Example:
  /// ```dart
  /// final chatRepository = ChatRepository(auth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance);
  /// final messagesStream = chatRepository.getMessages('currentUserId', 'otherUserId');
  /// messagesStream.listen((messages) {
  ///   // Handle the list of messages
  /// });
  /// ```
  Stream<List<MessageModel>> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("&");

    try {
      return fireStore
          .collection("chat-rooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) {}

        return snapshot.docs.map((doc) {
          return MessageModel.fromMap(doc.data());
        }).toList();
      });
    } catch (e) {
      log('Error fetching messages: $e');
      return Stream.value([]);
    }
  }
}
