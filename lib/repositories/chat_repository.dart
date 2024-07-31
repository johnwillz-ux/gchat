import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:g_chat/models/user_model.dart';

class ChatRepository extends ChangeNotifier {
  final FirebaseFirestore fireStore;

  ChatRepository({required this.fireStore});

  Future<List<UserModel>> fetchUsers(String currentUserUid) async {
    var usersSnapshot = await fireStore.collection('users').get();

    var userList = usersSnapshot.docs
        .map((doc) => UserModel.fromMap(doc.data()))
        .where((user) => user.uid != currentUserUid) // Exclude the current user
        .toList();

    return userList;
  }
}
