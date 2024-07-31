import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/models/user_model.dart';
import 'package:g_chat/repositories/chat_repository.dart';

class UserProvider with ChangeNotifier {
  final ChatRepository chatRepository;
  final FirebaseAuth auth;
  List<UserModel> _users = [];
  bool _isLoading = false;

  UserProvider({required this.chatRepository, required this.auth});

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

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
}
