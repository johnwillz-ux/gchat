// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:g_chat/common/snak_bar_notification.dart';
import 'package:g_chat/models/user_model.dart';
import 'package:g_chat/providers/user_provider.dart';
import 'package:g_chat/services/firebase_services.dart';
import 'package:g_chat/views/auth/onboard_view.dart';
import 'package:g_chat/views/navbar/nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This repository class handles authentication-related operations,
/// including user sign-up, sign-in, and sign-out. It also manages loading
/// state and stores user data in local storage.
class AuthRepository extends ChangeNotifier {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? currentUser;

  AuthRepository({
    required this.auth,
    required this.fireStore,
  });

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Signs up a new user and stores their data in local storage.
  ///
  /// [context] - The build context to show notifications and navigate.
  /// [email] - The email address of the user.
  /// [password] - The password for the user.
  /// [fullName] - The full name of the user.

  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
  }) async {
    _setLoading(true);

    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      currentUser = UserModel(
        uid: uid,
        fullName: fullName,
        email: email,
      );

      await fireStore.collection("users").doc(uid).set(currentUser!.toMap());

      // Save user data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userFullName', fullName);
      await prefs.setString('userEmail', email);

      notifyListeners();

      Navigator.pushNamed(context, NavBar.routeName);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getMessageFromErrorCode(e.code);
      ShowNotificationSnack.showError(context, "Error", errorMessage);
    } catch (e) {
      ShowNotificationSnack.showError(context, "Error", e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Signs in an existing user and stores their data in local storage.
  ///
  /// [context] - The build context to show notifications and navigate.
  /// [email] - The email address of the user.
  /// [password] - The password for the user.

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      var userDoc = await fireStore.collection("users").doc(uid).get();
      var user = UserModel.fromMap(userDoc.data()!);

      // Save user data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userFullName', user.fullName);
      await prefs.setString('userEmail', user.email);

      Navigator.pushNamed(context, NavBar.routeName);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getMessageFromErrorCode(e.code);
      ShowNotificationSnack.showError(context, "Error", errorMessage);
    } catch (e) {
      ShowNotificationSnack.showError(context, "Error", e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Signs out the current user and clears their data from local storage.

  void signOutUser(BuildContext context) async {
    try {
      await auth.signOut();

      /// Clear local storage and provider data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('fullName');
      await prefs.remove('email');

      /// Clear provider data
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.clearUsers();

      /// Navigate to login
      Navigator.pushNamedAndRemoveUntil(
          context, OnboardView.routeName, (route) => true);
    } catch (e) {
      ShowNotificationSnack.showError(context, "Error", e.toString());
    }
  }
}
