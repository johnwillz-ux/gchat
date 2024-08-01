import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/models/user_model.dart';
import 'package:g_chat/repositories/chat_repository.dart';

/// A provider class that manages the list of users in the chat application.
///
/// This class uses the [ChatRepository] to fetch the list of users and
/// notifies its listeners when the list changes.
class UserProvider with ChangeNotifier {
  /// The [ChatRepository] instance used to fetch the list of users.
  final ChatRepository chatRepository;

  /// The [FirebaseAuth] instance used to get the current user's UID.
  final FirebaseAuth auth;

  /// The list of users in the chat application.
  List<UserModel> _users = [];

  /// Whether the provider is currently loading the list of users.
  bool _isLoading = false;

  /// Creates a new [UserProvider] instance.
  ///
  /// [chatRepository] and [auth] must not be null.
  UserProvider({required this.chatRepository, required this.auth});

  /// Gets the list of users in the chat application.
  ///
  /// Returns an empty list if no users have been loaded yet.
  List<UserModel> get users => _users;

  /// Gets whether the provider is currently loading the list of users.
  bool get isLoading => _isLoading;

  /// Loads the list of users in the chat application.
  ///
  /// This method fetches the list of users from the [ChatRepository] and
  /// notifies its listeners when the list changes.

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      String currentUserUid = auth.currentUser!.uid;
      _users = await chatRepository.fetchUsers(currentUserUid);
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clears the list of users in the chat application.
  ///
  /// This method notifies its listeners when the list changes.

  void clearUsers() {
    _users.clear();
    notifyListeners();
  }
}